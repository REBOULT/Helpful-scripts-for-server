--[[--------------------------------------------------
								Flat HUD - by JAWS™
							Thanks for the download
--------------------------------------------------]]--

FlatUI = FlatUI or {}

-- Télécharger les contents lors de la connexion sous formes de fichier séparés 
FlatUI.DownloadContent = true

-- Télécharger les contents par le workshop et non en fichiers séparés (Si `FlatUI.DownloadContent` est activée) 
FlatUI.DlContentByWorkshop = true

-- Activation/désactivation de l'affichage de la faim
FlatUI.ShowHunger = false

-- Activation/désactivation des effets visuels lorsque que vous perdez de la vie
FlatUI.HealthEffects = true

-- Activation/désactivation des ombres des textes pour tout les joueurs (légère optimisation client MAIS n'est pas conseillée pour des raisons graphiques)
-- La commande console "flathud_shadow (true ou false)" permet d'effectuer la même chose pour l'utilisateur qui l'utilise
FlatUI.HUDShadows = true

-- Activation/désactivation de l'animation du texte lorsque vous êtes recherchés
FlatUI.WantedAnimText = false

-- Activation/désactivation de l'animation du texte lorsque qu'il y'a un couvre feu
FlatUI.LockdownAnimText = false

-- Armes ou l'affichage des munitions est désactivé 
-- Veillez à respecter la syntaxe (',' à la fin de ligne pour chaques valeurs)
FlatUI.WeaponBlackList = {
	[ "weapon_physcannon" ] = true
}

------------------------------------------------------------------------------
-- Personnalisation des icons utilisés dans l'hud (Attention aux tailles d'images !). 
-- Il est recommandé de ne pas modifier ce paramètre pour un affichage correct 

FlatUI.Materials = {
	Health = Material("flat_hud/health.png", "smooth"),
	Armor = Material("flat_hud/armor.png", "smooth"),
	Ammo = Material("flat_hud/ammo.png", "smooth"),
}