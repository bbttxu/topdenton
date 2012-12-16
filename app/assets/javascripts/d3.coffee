fontSize = d3.scale.log().range([10, 100])


do_text = (d) ->
  d.key

do_font_size = (d) ->
  fontSize(+d.value)

do_rotate = (d) ->
  ~~(Math.random() * 5) * 30 - 60

layout = cloud()
  .size([960, 600])
  .timeInterval(10)
  .text do_text
  .font("Impact")
  .fontSize do_font_size
  .rotate do_rotate
  .padding(1)
  .on("word", progress)
  .on("end", draw)
  .words([…])
  .start()
