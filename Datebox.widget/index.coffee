# A widget that shows current date.
# Assembled by Piotr Gajos
# https://github.com/Pe8er/Ubersicht-Widgets
# I don't know how to write code, so I obviously pulled pieces from all over the place, particularly from Chris Johnson's World Clock widget. Also big thanks to Josh "Baby Boi" Rutherford.

# Execute the shell command.
command: "Datebox.widget/Datebox.sh"

# Set the refresh frequency (milliseconds).
# refreshFrequency: 3600000
refreshFrequency: 1000

# CSS Style
style: """

  white06 = rgba(white,0.6)
  black02 = rgba(black,0.2)
  scale = 1
  bg-blur = 20px

  bottom: 8px * scale
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

  .date-bg-slice
    position: absolute
    top: -2*(bg-blur)
    left: -2*(bg-blur)
    width: 100% + 6*bg-blur
    height: 100% + 6*bg-blur
    -webkit-filter: blur(bg-blur)

  .day, .month
    overflow: hidden
    text-overflow: ellipsis

  .day
    font-weight: 700
    font-size: 16pt * scale
    line-height: @font-size
    overflow: visible
    padding-top: 6px * scale

  .month
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
  dateHTML = ''

  # Making my life easy
  day = values[0]
  month = values[1]

  # Make it disappear if nothing is playing

    # Create the DIVs for each piece of data.
  dateHTML = "
    <canvas class='date-bg-slice'></canvas>
    <div class='wrapper'>
      <div class='day'>" + day + "</div>
      <div class='month'>" + month + "</div>
    </div>"

  # Set the HTML of our main DIV.
  div.html(dateHTML)

  afterRender: (domEl) ->
  uebersicht.makeBgSlice(el) for el in $(domEl).find '.date-bg-slice'