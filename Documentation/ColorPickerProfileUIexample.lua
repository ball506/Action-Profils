Element is made as same as other elements in ProfileUI
            
               
    			{
                    E = "ColorPicker",            -- Element name ColorPicker
					ZONE = 'Panel',               -- @ZONE setting can be Panel, FontHeader, FontNormal, Border, Highlight, Window
                    COLOR = {
                        R = 1,                    -- Red color (0 - 1)
                        G = 0,                    -- Green color (0 - 1)
					    B = 0.3,                  -- Blue color (0 - 1)
					    A = 0.7,                  -- Alpha (0 - 1) (Transparency)
				    },
                    DB = "colorpickerPanel",
                    DBV = {
                        R = 1,                    -- Red color (0 - 1)
                        G = 0,                    -- Green color (0 - 1)
					    B = 0.3,                  -- Blue color (0 - 1)
					    A = 0.7,                  -- Alpha (0 - 1) (Transparency)
				    },
                    L = {                         -- Element Title
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    TT = {                        -- Tooltip
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    },                            -- No defaut right click behavior. Do you really need macro to set your UI color ? :D
                    M = {},
                },

-- All options snippet to copy paste in ProfileUI 
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Customizations -- ",
                    },
                },
            },			
            { -- [1] 1st Row
                {
                    E = "ColorPicker", 
					ZONE = 'Panel',
                    COLOR = {
                        R = 1, 
                        G = 0,  
					    B = 0.3,
					    A = 0.7,
				    },
                    DB = "colorpickerPanel",
                    DBV = {
                        R = 1, 
                        G = 0,  
					    B = 0.3,
					    A = 0.7,
				    },
                    L = { 
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    TT = { 
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    M = {},
                },
                {
                    E = "ColorPicker", 
					ZONE = 'Highlight',
                    COLOR = {
                        R = 1, 
                        G = 0,  
					    B = 0.3,
					    A = 0.7,
				    },
                    DB = "colorpickerHighlight",
                    DBV = {
                        R = 1, 
                        G = 0,  
					    B = 0.3,
					    A = 0.7,
				    },
                    L = { 
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    TT = { 
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    M = {},
                },
                {
                    E = "ColorPicker", 
					ZONE = 'Border',
                    COLOR = {
                        R = 1, 
                        G = 0,  
					    B = 0.3,
					    A = 0.7,
				    },
                    DB = "colorpickerBorder",
                    DBV = {
                        R = 1, 
                        G = 0,  
					    B = 0.3,
					    A = 0.7,
				    },
                    L = { 
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    TT = { 
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    M = {},
                },
                {
                    E = "ColorPicker", 
					ZONE = 'Window',
                    COLOR = {
                        R = 1, 
                        G = 0,  
					    B = 0.3,
					    A = 0.7,
				    },
                    DB = "colorpickerMain",
                    DBV = {
                        R = 1, 
                        G = 0,  
					    B = 0.3,
					    A = 0.7,
				    },
                    L = { 
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    TT = { 
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    M = {},
                },
                {
                    E = "ColorPicker", 
					ZONE = 'FontNormal',
                    COLOR = {
                        R = 1, 
                        G = 0,  
					    B = 0.3,
					    A = 0.7,
				    },
                    DB = "colorpickerFontNormal",
                    DBV = {
                        R = 1, 
                        G = 0,  
					    B = 0.3,
					    A = 0.7,
				    },
                    L = { 
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    TT = { 
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    M = {},
                },
                {
                    E = "ColorPicker", 
					ZONE = 'FontHeader',
                    COLOR = {
                        R = 1, 
                        G = 0,  
					    B = 0.3,
					    A = 0.7,
				    },
                    DB = "colorpickerFontHeader",
                    DBV = {
                        R = 1, 
                        G = 0,  
					    B = 0.3,
					    A = 0.7,
				    },
                    L = { 
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    TT = { 
                        enUS = "Colorpicker", 
                        ruRU = "Colorpicker",
                        frFR = "Colorpicker",
                    }, 
                    M = {},
                },
			},