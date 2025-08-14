-- Base
-- -1 Desconhecido
--  0 Arch
--  1 Debian
--  2 RedHat
--  3 Alpine
--  4 Gentoo
--  5 Solus


IS_BASE_NOT_FOUND = -1
IS_BASE_ARCH = 0
IS_BASE_DEBIAN = 1
IS_BASE_REDHAT = 2
IS_BASE_ALPINE = 3
IS_BASE_GENTOO = 4
IS_BASE_SOLUS = 5

local function detect_base()
  local function readfile(path)
    local f = io.open(path, "r")
    if not f then return "" end
    local content = f:read("*a")
    f:close()
    return content:lower()
  end

  -- 1. Tenta via /etc/os-release
  local os_release = readfile("/etc/os-release")
  if os_release:match("id_like=.*arch") or os_release:match("id=arch") then
    return 0
  elseif os_release:match("id_like=.*debian") or os_release:match("id_like=.*ubuntu")
    or os_release:match("id=debian") or os_release:match("id=ubuntu") then
    return 1
  elseif os_release:match("id_like=.*rhel") or os_release:match("id_like=.*fedora")
    or os_release:match("id_like=.*centos") or os_release:match("id=.*rhel")
    or os_release:match("id=.*fedora") or os_release:match("id=.*centos") then
    return 2
  elseif os_release:match("id_like=.*alpine") or os_release:match("id=alpine") then
    return 3
  elseif os_release:match("id_like=.*gentoo") or os_release:match("id=gentoo") then
    return 4
  elseif os_release:match("id_like=.*solus") or os_release:match("id=solus") then
    return 5
  end

  -- 2. Fallback: arquivos específicos
  if readfile("/etc/arch-release") ~= "" then
    return 0
  elseif readfile("/etc/debian_version") ~= "" then
    return 1
  elseif readfile("/etc/redhat-release") ~= "" then
    return 2
  elseif readfile("/etc/alpine-release") ~= "" then
    return 3
  elseif readfile("/etc/gentoo-release") ~= "" then
    return 4
  elseif readfile("/etc/solus-release") ~= "" then
    return 5
  end

  return -1
end

local function get_linux_name()
    local function readfile(path)
        local f = io.open(path, "r")
        if not f then return "" end
        local content = f:read("*a")
        f:close()
        return content
    end

    -- 1. Tenta via /etc/os-release
    local os_release = readfile("/etc/os-release")
    if os_release ~= "" then
        local name = os_release:match('^NAME="?(.-)"?$') or os_release:match('\nNAME="?(.-)"?$')
        if name then
            return name
        end
    end

    -- 2. Fallback: arquivos clássicos
    local files = {
        "/etc/arch-release",
        "/etc/debian_version",
        "/etc/redhat-release",
        "/etc/alpine-release",
        "/etc/gentoo-release",
        "/etc/solus-release"
    }
    for _, file in ipairs(files) do
        local content = readfile(file)
        if content ~= "" then
            return (file .. ": " .. content:gsub("\n", ""))
        end
    end

    return "Unknown Linux"
end

print(get_linux_name())


