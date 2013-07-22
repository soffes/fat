#= require chart

$ ->
  canvas$ = $('canvas')
  canvas = canvas$[0]
  window$ = $(window)

  resize = ->
    canvas$.css({
      width: $('section').width()
      height: 200
    })

    canvas.setAttribute('width', canvas$.width())
    canvas.setAttribute('height', canvas$.height())

    context = canvas.getContext('2d')
    new Chart(context).Line(fat.weight, {
      animation: false
      scaleFontFamily: "'Whitney A', 'Whitney B'"
      bezierCurve: false
    })

  window$.resize(resize)
  resize()
