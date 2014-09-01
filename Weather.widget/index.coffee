# Execute the shell command.
command: "Weather.widget/Weather.sh"

# Set the refresh frequency (milliseconds).
refreshFrequency: 100000

# CSS Style
style: """

  white06 = rgba(white,0.6)
  black02 = rgba(black,0.2)
  scale = 1
  bg-blur = 20px

  bottom: 6pt * scale
  left: 256pt * scale
  width: 80px * scale
  overflow: hidden
  white-space: nowrap
  opacity: 0

  .wrapper
    position: relative
    font-family: "Helvetica Neue"
    text-align: center
    font-size: 8pt * scale
    line-height: (20% / scale) * @font-size
    -webkit-font-smoothing: antialiased
    color: white
    background: black02
    border: 1px * scale solid white06
    padding: 6px 12px * scale

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
    font-size: 13pt * scale
    line-height: @font-size
    margin-left: 6px * scale

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
  if values[0] != ''

    # Create the DIVs for each piece of data.
    $(domEl).animate({ opacity: 1 }, 500)
    weatherHTML = "
      <canvas class='weather-bg-slice'></canvas>
      <div class='wrapper'>
        <div class='temp'>" + temp + "</div>
        <div class='cond'>" + cond + "</div>
      </div>"
  else
    $(domEl).animate({ opacity: 0 }, 500)

  # Set the HTML of our main DIV.
  div.html(weatherHTML)

  afterRender: (domEl) ->
  uebersicht.makeBgSlice(el) for el in $(domEl).find '.weather-bg-slice'