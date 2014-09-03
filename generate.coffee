CvInfo = require 'cv-info'
fs = require 'fs'

INFO_FILE = '/home/p/pro/nechifor-info/info.yaml'

genMajorProjects = (info) ->
  list = []
  major = info.projects.list.filter (p) -> p.tags.set.major
  for p in major
    uses = p.uses.list.join(', ').replace '#', '\\#'
    url = p.links.map.github.url
    list.push "\\longDesc{#{p.name}}{#{uses}}{#{p.desc}}{#{url}}\n"
  list.join '\n'

genMinorProjects = (info) ->
  list = []
  minor = info.projects.list.filter (p) -> not p.tags.set.major
  minor = minor.filter (p) -> not p.tags.set.cvOff
  for p in minor
    url = if p.links.map.github then p.links.map.github.url else p.url()
    list.push "\\href{#{url}}{#{p.desc}}"
  list.join '\n\\sep{} '

main = ->
  info = new CvInfo.Info
  info.loadFromFile INFO_FILE, (err) ->
    throw err if err
    fs.writeFileSync __dirname + '/cv-projects-major.gen.tex',
        genMajorProjects info
    fs.writeFileSync __dirname + '/cv-projects-minor.gen.tex',
        genMinorProjects info

main()
