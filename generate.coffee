CvInfo = require 'cv-info'
fs = require 'fs'

INFO_FILE = '/home/p/pro/nechifor-info/info.yaml'

generateFile = (info) ->
  ret = ''
  major = info.projects.list.filter (p) -> p.tags.set.major
  for p in major
    uses = p.uses.list.join(', ').replace '#', '\\#'
    url = p.links.map.github.url
    ret += "\\longDesc{#{p.name}}{#{uses}}{#{p.desc}}{#{url}}\n\n"
  ret

main = ->
  info = new CvInfo.Info
  info.loadFromFile INFO_FILE, (err) ->
    throw err if err
    content = generateFile info
    fs.writeFileSync __dirname + '/cv-projects-major.gen.tex', content

main()
