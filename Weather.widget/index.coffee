# A widget that shows current weather.
# Assembled by Piotr Gajos
# https://github.com/Pe8er/Ubersicht-Widgets
# I don't know how to write code, so I obviously pulled pieces from all over the place, particularly from Chris Johnson's World Clock widget. Also big thanks to Josh "Baby Boi" Rutherford.

# jq required for use:  http://stedolan.github.io/jq/
# Optionally just use brew:  'brew install jq'

# Execute the shell command.
command: "Weather.widget/Weather.sh"

# Set the refresh frequency (milliseconds).
refreshFrequency: 60000

# CSS Style
style: """

  white06 = rgba(white,0.6)
  black02 = rgba(black,0.2)
  scale = 1
  bg-blur = 20px

  bottom: (60px + 8) * scale
  left: 8px * scale
  width: 80px * scale
  overflow: hidden
  white-space: nowrap

  .wrapper
    position: relative
    font-family: "Helvetica Neue"
    text-align: center
    font-size: 8pt * scale
    line-height: (@font-size + 30%) * scale
    -webkit-font-smoothing: antialiased
    color: white
    background: black02
    border: 1px * scale solid white06
    height: 50px * scale

  .weather-bg-slice
    position: absolute
    top: -2*(bg-blur)
    left: -2*(bg-blur)
    width: 100% + 6*bg-blur
    height: 100% + 6*bg-blur
    -webkit-filter: blur(bg-blur)

  .temp, .cond
    overflow: hidden
    text-overflow: ellipsis

  .temp
    font-weight: 700
    font-size: 18pt * scale
    line-height: @font-size
    margin-left: 8px * scale
    overflow: visible
    padding-top: 6px * scale

  .cond
    color:white06

  """


# Render the output.
render: -> """
"""

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  # Get our pieces
  values = output.split("\n")

  # Initialize our HTML.
  weatherHTML = ''

  # Making my life easy
  loc = values[0]
  cond = values[1]
  temp = values[2]

  # Make it disappear if nothing is playing

    # Create the DIVs for each piece of data.
  weatherHTML = "
    <canvas class='weather-bg-slice'></canvas>
    <div class='wrapper'>
      <div class='temp'>" + temp + "</div>
      <div class='cond'>" + cond + "</div>
    </div>"

  # Set the HTML of our main DIV.
  div.html(weatherHTML)

  afterRender: (domEl) ->
  uebersicht.makeBgSlice(el) for el in $(domEl).find '.weather-bg-slice'