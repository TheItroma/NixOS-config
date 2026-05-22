----------------
---- CURVES ----
----------------

hl.curve("bounce", { type = "spring", mass = 1, stiffness = 50, dampening = 10 })
hl.curve("slight_bounce", { type = "spring", mass = 1, stiffness = 35, dampening = 10 })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.5 }, { 0.45, 1 } } })
hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0 }, { 0.35, 1 } } })
hl.curve("easeInOutQuad", { type = "bezier", points = { { 0.45, 0 }, { 0.55, 1 } } })
hl.curve("easeInOutSine", { type = "bezier", points = { { 0.37, 0 }, { 0.63, 1 } } })

----------------------
---- ANIMATIONS ------
----------------------
hl.animation({ leaf = "border", enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 0.8, spring = "slight_bounce", style = "popin 40%" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 1.5, bezier = "easeInOutQuad", style = "slide 100%" })
