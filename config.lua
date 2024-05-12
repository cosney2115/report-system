Config = Config or {}

Config.AdminCommand = "reports"
Config.ReportCommand = "report"

Config.Roles = {
    "admin",
    "superadmin"
}

Config.Notify = {
    ReportSent = "Report sent",
    Teleported = "Teleported to player",
    ReportClosed = "Report closed",
    Revived = "Player revived"
}

Config.BanFunction = function(source)
    -- Your ban code here
end


Config.Suggestions = {
    [Config.ReportCommand] = "Report a player",
    [Config.AdminCommand] = "Dashboard for reports [ADMIN ONLY]"
}