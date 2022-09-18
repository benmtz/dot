local M = {}

local butterfly = {
[[ ¶                                               ¶ ]],
[[  ¶                                             ¶  ]],
[[   ¶¶¶                                       ¶¶¶   ]],
[[     ¶¶¶¶                                 ¶¶¶¶     ]],
[[ ¶     ¶ ¶¶¶                           ¶¶¶ ¶     ¶ ]],
[[  ¶¶        ¶¶                       ¶¶        ¶¶  ]],
[[  ¶¶¶¶¶        ¶¶                 ¶¶        ¶¶¶¶¶  ]],
[[   ¶¶¶¶¶¶¶¶      ¶¶              ¶      ¶¶¶¶¶¶¶¶   ]],
[[     ¶¶¶¶¶¶¶¶¶¶    ¶           ¶    ¶¶¶¶¶¶¶¶¶¶     ]],
[[         ¶¶¶¶¶¶¶¶¶   ¶       ¶   ¶¶¶¶¶¶¶¶¶         ]],
[[    ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶ ¶     ¶ ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶    ]],
[[        ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶     ¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶        ]],
[[          ¶¶¶¶¶¶¶¶¶¶¶¶¶¶   ¶¶¶¶¶¶¶¶¶¶¶¶¶¶          ]],
[[         ¶   ¶¶¶  ¶¶¶         ¶¶¶  ¶¶¶   ¶         ]],
[[             ¶  ¶      ¶   ¶      ¶  ¶             ]],
[[               ¶    ¶¶¶     ¶¶¶    ¶               ]],
[[                  ¶¶¶¶       ¶¶¶¶                  ]],
[[                ¶¶¶¶¶         ¶¶¶¶¶                ]],
[[              ¶¶¶¶¶¶           ¶¶¶¶¶¶              ]],
[[             ¶¶¶¶¶¶             ¶¶¶¶¶¶             ]],
[[            ¶¶¶¶¶¶¶             ¶¶¶¶¶¶¶            ]],
[[            ¶¶¶¶¶ ¶             ¶ ¶¶¶¶¶            ]],
[[           ¶ ¶¶¶¶  ¶              ¶¶¶¶ ¶           ]],
[[           ¶¶  ¶¶                 ¶¶  ¶¶           ]],
[[                ¶                 ¶                ]],
[[          ¶                             ¶          ]],
[[          ¶                             ¶          ]],
}

local impossible_one = {
[[  _______________________________]],
[[ /\                              \]],
[[/++\    __________________________\]],
[[\+++\   \ ************************/]],
[[ \+++\   \___________________ ***/]],
[[  \+++\   \             /+++/***/]],
[[   \+++\   \           /+++/***/]],
[[    \+++\   \         /+++/***/]],
[[     \+++\   \       /+++/***/]],
[[      \+++\   \     /+++/***/]],
[[       \+++\   \   /+++/***/]],
[[        \+++\   \ /+++/***/]],
[[         \+++\   /+++/***/]],
[[          \+++\ /+++/***/]],
[[           \+++++++/***/]],
[[            \+++++/***/]],
[[             \+++/***/]],
[[              \+/___/]],
}

local trafalgar = {
[[             ▄▄██████████▄▄             ]],
[[             ▀▀▀   ██   ▀▀▀             ]],
[[     ▄██▄   ▄▄████████████▄▄   ▄██▄     ]],
[[   ▄███▀  ▄████▀▀▀    ▀▀▀████▄  ▀███▄   ]],
[[  ████▄ ▄███▀              ▀███▄ ▄████  ]],
[[ ███▀█████▀▄████▄      ▄████▄▀█████▀███ ]],
[[ ██▀  ███▀ ██████      ██████ ▀███  ▀██ ]],
[[  ▀  ▄██▀  ▀████▀  ▄▄  ▀████▀  ▀██▄  ▀  ]],
[[     ███           ▀▀           ███     ]],
[[     ██████████████████████████████     ]],
[[ ▄█  ▀██  ███   ██    ██   ███  ██▀  █▄ ]],
[[ ███  ███ ███   ██    ██   ███▄███  ███ ]],
[[ ▀██▄████████   ██    ██   ████████▄██▀ ]],
[[  ▀███▀ ▀████   ██    ██   ████▀ ▀███▀  ]],
[[   ▀███▄  ▀███████    ███████▀  ▄███▀   ]],
[[     ▀███    ▀▀██████████▀▀▀   ███▀     ]],
[[       ▀     ▄▄▄   ██   ▄▄▄      ▀      ]],
[[             ▀▀███████████▀            ]]
                                        
}

local key = {
[[                      ]],
[[       =IY;           ]],
[[      XRVRRi          ]],
[[     =Ri :RR          ]],
[[     VR  ;RR          ]],
[[     RY  tRY          ]],
[[     RX ;RR;          ]],
[[     tR=RRR           ]],
[[     ;RRRR;           ]],
[[     ;RRRi            ]],
[[    ;RRRV             ]],
[[   ;RRRRR:            ]],
[[  :RRRV.RX            ]],
[[  VRRR: ;R=           ]],
[[ =RRR+   YRitti;.     ]],
[[ VRRR  :YRRRRRRRRt.   ]],
[[.RRRY ;RRYYR;;iRRRR.  ]],
[[:RRRi RR; .Rt  .XRRY  ]],
[[:RRR= RV   +R.  .RRR  ]],
[[:RRRt tR    Rt   IRR. ]],
[[ RRRR  ;;   +R.  XRY  ]],
[[ ;RRRt      .R+ +RR:  ]],
[[  ;RRRX;     YRIRX:   ]],
[[   .+RRRRIiitRRY;     ]],
[[      :;+ii+;tR:      ]],
[[             ;R:      ]],
[[             iR       ]],
[[    ;VRRi    Vi       ]],
[[    RRRRR.  tR.       ]],
[[    YRRR+ ;YV:        ]],
[[    .tRRRRR+          ]],
[[      .;;:            ]],
[[                      ]],
}

local ut_key = {
[[        ..,,,,,..]],
[[    .,;;;;;;;;;;;;;;,.]],
[[  ,;;;'            `;;;;,       ,,]],
[[ ,;'                 ';;;;,    ;;;;]],
[[.;.;;;;,               ;;;;;.   '']],
[[;;;;;;;;                ;;;;;]],
[[`;;;;;;'                ;;;;;]],
[[                        ;;;;'   ,,]],
[[                      .;;;;'   ;;;;]],
[[                     ,;;;'      '']],
[[                   ,;;;']],
[[                ,;;;']],
[[            .;;;;']],
[[        .,;;;'']],
[[    .,;;'']],
}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require "alpha.themes.dashboard"
  dashboard.section.header.val = key

  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
    dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
    dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
    dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  dashboard.section.footer.opts.hl = "Type"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Keyword"

  dashboard.opts.opts.noautocmd = true
  alpha.setup(dashboard.opts)
end

return M
