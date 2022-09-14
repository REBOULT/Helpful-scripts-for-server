SHUD = {}
SHUD.Config = {}
SHUD.Config.DLC = {}
SHUD.Config.Icon = {}
SHUD.Config.Text = {}
SHUD.Config.Addon = {}
SHUD.Config.Color = {}
SHUD.Config.Ranks = {}


SHUD.Config.DarkRP              = false                  -- Using DarkRP?
SHUD.Config.Second              = fals                  -- Show the second bar (HP and Job)
SHUD.Config.Showrank            = true                  -- Show the rank of admins
SHUD.Config.ShowEx              = "health"              -- false = disabled, Use health or armor.
SHUD.Config.Range               = 1000                  -- Range of the player card
SHUD.Config.Round               = 1                    -- The main box: 1 = Default , 2 = Square
SHUD.Config.Font                = 1                     -- Text fonts: 1 = Default, 2 = SHUD BIG, 3 = Old School
SHUD.Config.Lang                = 1                     -- Languages: 1 = English, 2 = Swedish, 3 = Danish
SHUD.Config.RHide               = 'false'               -- Usergroup (SHUD will be deactivated for this person)

SHUD.Config.Showwanted  	      = false                  -- Show if a player is wanted
SHUD.Config.Patrol              = "TEAM_ADMIN"          -- Name of the admin class (The SHUD will be deactivated for this class)
SHUD.Config.Wanted              = "Custom Wanted Text"  -- Custom wanted text, set Lang to 4 to use this


SHUD.Config.Icon.Gun            = "gun"                 -- Silkicon for the gun
SHUD.Config.Icon.Paper          = "page"                -- Silkicon for the paper
SHUD.Config.Icon.Warning        = "stop"                -- Silkicon for the warning sign

SHUD.Config.Addon.Showgang      = false                 -- Show gang name (DarkRP Gang System) (Not 100% sure if its working)
SHUD.Config.Addon.GangSize      = "medium"              -- Text size (small/medium/large)
SHUD.Config.Addon.Showorg       = false                 -- Show org name (Organisations Addon for DarkRP)
SHUD.Config.Addon.OrgSize       = "medium"              -- Text size (small/medium/large)


SHUD.Config.DLC.Tag             = false                 -- Custom tag (SHUD Tag System)


SHUD.Config.Color.Nametext      = Color(0,0,0,220)
SHUD.Config.Color.Namebg        = Color(255,255,255)

SHUD.Config.Color.Jobtext       = Color(255,255,255)
SHUD.Config.Color.Jobbg         = Color(255,255,255)

SHUD.Config.Color.Ranktext      = Color(255,255,255,180)
SHUD.Config.Color.Rankbg        = Color(0,0,0,180)

SHUD.Config.Addon.Gangcolor     = Color(0,0,0,180)
SHUD.Config.Addon.Gangtext      = Color(255,255,255,255)
SHUD.Config.Addon.Orgcolor      = Color(10,10,10,180)
SHUD.Config.Addon.Orgtext       = Color(255,255,255,255)


SHUD.Config.Ranks["superadmin"] = {"Разработчик", "shield_add", Color(205,0,0,180), Color(255,255,255,180)}
SHUD.Config.Ranks["admin"]      = {"Администратор", "shield", Color(255,255,0,180), Color(255,255,255,180)}
SHUD.Config.Ranks["spec"]      = {"Смотрящий", "shield", Color(0,255,255,180), Color(255,255,255,180)}