_ = require 'lodash'

module.exports = (System) ->
  Identity = System.getModel 'Identity'

  globals =
    public:
      blog:
        socialLinks: {}
        # settings:
        #   socialLinks: 'kerplunk-blog-social-links:show'

  globals: globals

  init: (next) ->
    # Blog = System.getPlugin 'kerplunk-blog'
    Identity.getMe (err, me) ->
      return next() if err # just give up
      return next() unless me.data and Object.keys(me.data).length > 0
      for platform, platformData of me.data
        # console.log 'another me!', platform, platformData.profileUrl
        if platformData.profileUrl
          globals.public.blog.socialLinks[platform] = platformData.profileUrl
        # globals.public.blog.settings.socialLinks
      next()
