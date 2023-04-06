-- KLYAR's Config

-- Default
import XMonad hiding ((|||))
import Data.Monoid
import System.Exit
import XMonad.Util.Run
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
-- Layouts
import XMonad.Layout.ResizableTile        -- A alternative to Tall Layout
import XMonad.Layout.BinarySpacePartition -- Each window divides in two
import XMonad.Layout.Tabbed               -- Tabs on top
-- Layout modifiers
import XMonad.Layout.Spacing           -- Adds some space between the windows
import XMonad.Layout.NoBorders         -- Removes the borders
import XMonad.Layout.LayoutCombinators -- To combine the layouts and use JumpToLayout
import XMonad.Layout.Renamed           -- Rename the layouts
-- XMobar
import XMonad.Hooks.ManageDocks -- To the windows don't hide the bar
import XMonad.Hooks.DynamicLog  -- To transfer data to XMobar
-- Run prompt
import XMonad.Prompt
import XMonad.Prompt.Shell
-- More
import XMonad.Hooks.InsertPosition 
import XMonad.Hooks.EwmhDesktops


------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask  , xK_Return ), spawn $ XMonad.terminal conf)

    -- Launches Firefox
    , ((modm .|. shiftMask  , xK_b      ), spawn "qutebrowser")

    -- launch rofi
    , ((modm .|. shiftMask  , xK_r      ), spawn "rofi -no-lazy-grab -show drun -modi drun -theme ~/.config/rofi/theme.rasi")

    -- launch dmenu
    , ((modm .|. shiftMask  , xK_p      ), spawn "dmenu_run -l 20")

    -- close focused window
    , ((modm .|. shiftMask  , xK_c      ), kill)

     -- Rotate through the available layout algorithms
    , ((modm                , xK_space  ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask  , xK_space  ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm                , xK_n      ), refresh)

    -- Move focus to the next window
    , ((modm                , xK_j      ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm                , xK_k      ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm                , xK_m      ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm                , xK_Return ), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask  , xK_j      ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask  , xK_k      ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm                , xK_h      ), sendMessage Shrink)

    -- Expand the master area
    , ((modm                , xK_l      ), sendMessage Expand)

    -- Shrink the non master area
    , ((modm .|. shiftMask  , xK_h      ), sendMessage MirrorShrink)

    -- Expand the non master area
    , ((modm .|. shiftMask  , xK_l      ), sendMessage MirrorExpand)

    -- Push window back into tiling
    , ((modm                , xK_t      ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm                , xK_comma  ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm                , xK_period ), sendMessage (IncMasterN (-1)))

    -- Go full screen
    , ((modm .|. shiftMask  , xK_f      ), sendMessage $ JumpToLayout "Full")

    -- Hide xmobar
    , ((modm                , xK_b      ), sendMessage ToggleStruts)
    
    -- Quit xmonad
    , ((modm .|. shiftMask  , xK_q      ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm                , xK_q      ), spawn ("xmonad -recompile; xmonad -restart"))
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)

        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events --
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
-- Note that each layout is separated by |||,
-- which denotes layout choice.

-- Tabbed style config
myTabConfig = def { activeColor         = "#77bdfb"
                  , activeBorderColor   = "#77bdfb"
                  , activeTextColor     = "#0d1117"
                  , inactiveColor       = "#0d1117"
                  , inactiveBorderColor = "#0d1117"
                  , inactiveTextColor   = "#89929b"
                  , urgentColor         = "#7ce38b"
                  , urgentBorderColor   = "#7ce38b"
                  , urgentTextColor     = "#0d1117"
                  , fontName            = "xft:Liberation Sans:pixelsize=13:antialias=true:hinting=true" }

myLayout = ( tiled
         ||| mirrortiled ||| bsp ||| mirrorbsp ||| tabs ||| fullscreen)
         where

     -- default tiling algorithm partitions the screen into two panes with more adjustment
     tiled_template = withBorder 1 $ spacingWithEdge 2 $ ResizableTall nmaster delta ratio []
     tiled          = renamed [Replace "Tiled" ] $ avoidStruts $ tiled_template
     mirrortiled    = renamed [Replace "MTiled"] $ avoidStruts $ Mirror tiled_template

     -- Real fullscreen
     fullscreen     = renamed [Replace "Full"  ] $ noBorders $ Full

     -- Tabbed windows
     tabs           = renamed [Replace "Tabs"  ] $ avoidStruts $ noBorders $ tabbed shrinkText myTabConfig

     -- Selected window divides into two
     bsp_template   = withBorder 1 $ spacingWithEdge 2 $ emptyBSP
     bsp            = renamed [Replace "bsp"   ] $ avoidStruts $        bsp_template
     mirrorbsp      = renamed [Replace "Mbsp"  ] $ avoidStruts $ Mirror bsp_template

     -- The default number of windows in the master pane
     nmaster        = 1

     -- Default proportion of screen occupied by master pane
     ratio          = 1/2

     -- Percent of screen to increment by when resizing panes
     delta          = 3/100

------------------------------------------------------------------------
-- Window rules:
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.

myManageHook = insertPosition End Newer <+> (composeAll
    [ className =? "bitwig-studio"        --> doFloat
    , resource  =? "desktop_window" --> doIgnore])

------------------------------------------------------------------------
-- Event handling
-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  

myStartupHook = do
  --spawnOnce "lxsession"
  spawn "xrandr -s 1920x1080"
  spawn "nitrogen --set-scaled --restore &"
  spawn "setxkbmap de &"
  spawn "xsetroot -cursor_name left_ptr &"
  spawn "picom"

main :: IO ()
main = do
    xmonad . ewmh =<< xmobar def {
        -- Basic configurations
        terminal           = "rxvt-unicode",
        focusFollowsMouse  = True,
        clickJustFocuses   = False,
        borderWidth        = 2,
        modMask            = mod4Mask,
        workspaces         = ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
        normalBorderColor  = "#0d1117",
        focusedBorderColor = "#a2d2fb",

        -- Key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

        -- Hooks
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        startupHook        = myStartupHook }
    
