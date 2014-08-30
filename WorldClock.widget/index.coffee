# Execute the shell command.
command: "WorldClock.widget/WorldClock.sh"

# Set the refresh frequency (milliseconds).
refreshFrequency: 1000

# CSS Style
style: """

  white05 = rgba(white,0.5)
  white01 = rgba(white,0.1)
  scale = 1
  bg-blur = 20px

  bottom: 6pt * scale
  left: 6pt * scale
  overflow: hidden
  white-space: nowrap
  text-overflow: ellipsis

  .wrapper
    position: relative
    font-family: HelveticaNeue
    text-align:center
    font-size:8pt * scale
    line-height: 20% * @font-size
    text-shadow: 0 1px 1px * scale rgba(black,0.3)
    -webkit-font-smoothing: antialiased
    background:white01
    border:1px * scale solid white05
    border-right:none

  .clock-bg-slice
    position: absolute
    top: -(bg-blur)
    left: -(bg-blur)
    width: 100% + 6*bg-blur
    height: 100% + 6*bg-blur
    -webkit-filter: blur(bg-blur)

  .box, .lastbox
    width:80px * scale
    display:inline-block
    border-right:1px * scale solid white05

  .Timezone
    color: white05
    padding:(6px * scale) (12px * scale)
    padding-top:0px

  .Time
    color: white
    font-weight: 700
    padding:(6px * scale) (12px * scale)
    padding-bottom:0px
"""


# Render the output.
render: -> """
"""

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  # Get our timezones and times.
  zones=output.split("\n")

  # Initialize our HTML.
  timeHTML = ''

  # Loop through each of the time zones.
  for zone, idx in zones

    # If the zone is not empty (e.g. the last newline), let's add it to the HTML.
    if zone != ''

      # Split the timezone from the time.
      values = zone.split(";")

      # Create the DIVs for each timezone/time. The last item is unique in that we don't want to display the border.
      if idx < zones.length - 2
        timeHTML = timeHTML + "<div class='box'><div class='Time'>" + values[1] + "</div><div class='Timezone'>" + values[0] + "</div></div>"
      else
        timeHTML = timeHTML + "<div class='lastbox'><div class='Time'>" + values[1] + "</div><div class='Timezone'>" + values[0] + "</div></div>"

  # Set the HTML of our main DIV.
  div.html("<canvas class='clock-bg-slice'></canvas><div class='wrapper'>" + timeHTML + "</div>")

  afterRender: (domEl) ->
  uebersicht.makeBgSlice(el) for el in $(domEl).find '.clock-bg-slice'