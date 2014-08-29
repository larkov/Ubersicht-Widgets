# Execute the shell command.
command: "WorldClock.widget/WorldClock.sh"

# Set the refresh frequency (milliseconds).
refreshFrequency: 1000

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
        timeHTML = timeHTML + "<div class='Wrapper'><div class='Time'>" + values[1] + "</div><div class='Timezone'>" + values[0] + "</div></div>"
      else
        timeHTML = timeHTML + "<div class='LastWrapper'><div class='Time'>" + values[1] + "</div><div class='Timezone'>" + values[0] + "</div></div>"

  # Set the HTML of our main DIV.
  div.html(timeHTML)


  # Change the location of the border, depending on whether or not the Wrapper DIVs are the same size as the overall DIV (i.e. the display is vertical).

# CSS Style
style: """

  white05 = rgba(white,0.5)
  white01 = rgba(white,0.2)
  scale = 1

  bottom: 6pt * scale
  left: 6pt * scale
  font-family: HelveticaNeue
  text-align:center
  font-size:8pt * scale
  line-height: 1.5
  -webkit-font-smoothing: antialiased
  background:white01
  border:1px * scale solid white05
  border-right:none

  .Wrapper, .LastWrapper
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
