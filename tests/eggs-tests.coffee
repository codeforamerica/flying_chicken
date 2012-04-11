fs = require 'fs'
eggs = require '../objects/eggs'

exports.eggs = {
  setUp: (callback) ->
    config = {
      eggs: { 
        office_chicken: 'http://173.228.102.131:6178/receive_commit',
        postbin: 'http://requestb.in/149jot61'
      }
    }
    @eggs = new eggs config
    
    @payload = JSON.parse(fs.readFileSync(__dirname + "/payload-test.json"))
    callback() # required!
  ,
  tearDown: (callback) ->
    delete @eggs
    delete @payload
    callback() # required!
  ,
  "Throw eggs": (test) ->
    console.log @payload
    @eggs.throw_eggs @payload
    test.done()
}
