# Execute the shell command.
command: "WorldClock.widget/WorldClock.sh"

# Set the refresh frequency (milliseconds).
refreshFrequency: 1000

# CSS Style
style: """

  white05 = rgba(white,0.6)
  white01 = rgba(black,0.2)
  scale = 1
  bg-blur = 20px

  bottom: 8px * scale
  left: (88px + 8) * scale
  overflow: hidden
  white-space: nowrap
  text-overflow: ellipsis

  .wrapper
    position: relative
    font-family: "Helvetica Neue"
    text-align: center
    font-size: 8pt * scale
    line-height: 12pt * scale
    -webkit-font-smoothing: antialiased
    background: white01
    border: 1px * scale solid white05
    border-right: none

  .clock-bg-slice
    position: absolute
    top: -(bg-blur)
    left: -(bg-blur)
    width: 100% + 6*bg-blur
    height: 100% + 6*bg-blur
    -webkit-filter: blur(bg-blur)

  .box, .lastbox
    width: 80px * scale
    height: 50px * scale
    display: inline-block
    border-right:1px * scale solid white05

  .Time
    color: white
    font-weight: 700
    padding: 8px * scale
    padding-bottom: 0

  .Timezone
    color: white05
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