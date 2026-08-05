hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

-- -- Fallback para HDMI-A-1
-- hl.monitor({
-- 	output = "HDMI-A-1",
-- 	mode = "auto",
-- 	position = "0x0",
-- 	scale = "1.0",
-- 	-- mirror = "eDP-1",
-- })

hl.monitor({
	output = "eDP-1",
	mode = "1920x1200@60",
	position = "0x1080",
	scale = "1.0",
})

-- Monitor de Casa
hl.monitor({
	output = "desc:AOC 24G2W1G4 0x00000183",
	mode = "1920x1080@144",
	position = "0x0",
	scale = "1.0",
})

-- Quando o AOC (casa) estiver conectado, ele recebe os workspaces 1-5.
-- Se ele não estiver conectado, essas regras ficam "sem efeito" e os
-- workspaces abrem normalmente no monitor ativo (o notebook).
hl.workspace_rule({ workspace = "1", monitor = "desc:AOC 24G2W1G4 0x00000183", default = true })
hl.workspace_rule({ workspace = "2", monitor = "desc:AOC 24G2W1G4 0x00000183" })
hl.workspace_rule({ workspace = "3", monitor = "desc:AOC 24G2W1G4 0x00000183" })
hl.workspace_rule({ workspace = "4", monitor = "desc:AOC 24G2W1G4 0x00000183" })
hl.workspace_rule({ workspace = "5", monitor = "desc:AOC 24G2W1G4 0x00000183" })

-- eDP-1 (notebook) sempre fica com 6-10, esteja ou não o AOC conectado.
hl.workspace_rule({ workspace = "6", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "7", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "8", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "9", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "10", monitor = "eDP-1" })

hl.window_rule({
	name = "pavucontrol-float",
	match = { class = "org.pulseaudio.pavucontrol" },
	float = true,
	size = "900 600",
	center = true,
})

hl.window_rule({
	name = "qalculate-gtk-float",
	match = { class = "qalculate-gtk" },
	float = true,
	size = "500 600",
	center = true,
})
