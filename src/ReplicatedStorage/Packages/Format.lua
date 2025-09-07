local module = {}

local Suffixes = {
    "", "k", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No",
    "Dc", "UDc", "DDc", "TDc", "QADc", "QIDc", "SXDc", "SPDc", "OCDc", "NODc",
    "Vg", "UVg", "DVg", "TVg", "QAVg", "QIVg", "SXVg", "SPVg", "OCVg", "NOVg",
    "Tg", "UTg", "DTg", "TTg", "QATg", "QITg", "SXTg", "SPTg", "OCTg", "NOTg",
    "Qd", "UQd", "DQd", "TQd", "QAQd", "QIQd", "SXQd", "SPQd", "OCQd", "NOQd",
    "Qq", "UQq", "DQq", "TQq", "QAQq", "QIQq", "SXQq", "SPQq", "OCQq", "NOQq",
    "Sg", "USg", "DSg", "TSg", "QASg", "QISg", "SXSg", "SPSg", "OCSg", "NOSg",
    "St", "USt", "DSt", "TSt", "QASt", "QISt", "SXSt", "SPSt", "OCSt", "NOSt",
    "Og", "UOg", "DOg", "TOg", "QAOg", "QIOg", "SXOg", "SPOg", "OCOg", "NOOg",
    "Ng", "UNg", "DNg", "TNg", "QANg", "QINg", "SXNg", "SPNg", "OCNg", "NONg",
    "Ce", "UCe", "DCe", "TCe", "QACe", "QICe", "SXCe", "SPCe", "OCCe", "NOCe"
}

function module.FormatNumber(Number: number): string
    if Number == 0 then
        return "0"
    end

    local exponent = math.floor(math.log10(Number))
    local index = math.floor(exponent / 3) + 1 

    if index > #Suffixes then
        index = #Suffixes
    end

    local scaled = Number / (1000 ^ (index - 1))
    return string.format("%.2f", scaled) .. Suffixes[index]
end

function module.UnFormatNumber(Str: string)
    local numPart, suffixPart = string.match(Str, "([%d%.]+)(%a*)")
    local number = tonumber(numPart)
    if not number then return nil end

    local index = 1
    for i, s in ipairs(Suffixes) do
        if s == suffixPart then
            index = i
            break
        end
    end

    return number * (1000 ^ (index - 1))
end

return module