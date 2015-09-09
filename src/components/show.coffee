_ = require 'lodash'
React = require 'react'

{DOM} = React

module.exports = React.createFactory React.createClass
  getInitialState: ->
    uid = 0
    socialLinks = @props.blogSettings['social-links'] ? []
    for socialLink in socialLinks
      socialLink.uid = ++uid
    socialLinks: socialLinks
    uid: uid

  addLink: (e) ->
    e.preventDefault()
    uid = @state.uid + 1
    @setState
      socialLinks: @state.socialLinks.concat [{name: '', url: '', uid: uid}]
      uid: uid

  removeLink: (index) ->
    (e) =>
      e.preventDefault()
      @setState
        socialLinks: _.filter @state.socialLinks, (link, i) -> i != index

  render: ->
    {socialLinks} = @state

    DOM.div null,
      DOM.h3 null, 'social links'
      DOM.pre null, JSON.stringify socialLinks
      _.map socialLinks, (socialLink, index) =>
        DOM.div
          key: "social-link-#{socialLink.uid}"
        ,
          DOM.input
            name: "social-links[#{index}][name]"
            defaultValue: socialLink.name
            placeholder: 'site'
          DOM.input
            name: "social-links[#{index}][url]"
            defaultValue: socialLink.url
            placeholder: 'url'
          DOM.button
            className: 'btn btn-xs btn-danger'
            onClick: @removeLink index
          , 'remove'
      DOM.div null,
        DOM.button
          className: 'btn btn-xs btn-success'
          onClick: @addLink
        , 'add link'
