-- import for button
local widget = require( "widget" )
-- import for Vungle ads
local ads = require "ads"

-- you need to change this to your App ID
appID = "vungleTest";

ads.init( "vungle", appID );

_H = display.contentHeight;
_W = display.contentWidth;

-- Function to handle button events
local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
        ads.show( "interstitial", { isBackButtonEnabled = true } );
    end
end

-- Create the button
local adButton = widget.newButton
{
    width = 120,
    height = 60,
    defaultFile = "images/greenButton.png",
    label = "Play Ad",
    labelColor = { default = { 163, 25, 12 }, over = { 163, 25, 12} },
    emboss = true,
    onRelease = handleButtonEvent
}
-- Change the button's position
adButton.x = _W / 2;
adButton.y = _H / 2;
