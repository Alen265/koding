###
  todo:
###

class NSetPermissionsView extends JView

  ###
  CLASS CONTEXT
  ###

  permissionsToOctalString = (permissions)->
    str = permissions.toString 8
    str = "0" + str while str.length < 3
    return str

  ###
  INSTANCE METHODS
  ###

  constructor: ->

    super

    @switches = []

    @setPermissionsButton = new KDButtonView
      title     : "Set"
      callback  : =>
        permissions = permissionsToOctalString @getPermissions()
        recursive   = @recursive.getValue() or no
        file        = @getData()
        file.chmod {permissions, recursive}, (err,res)=>
          unless err
            @displayOldOctalPermissions()

    @fetchPermissionsButton = new KDButtonView
      title : "Fetch file permissions"
      callback: ->
        log "fetch"
        # setPermissionsView.getDelegate().fetch ->
        #   setPermissionsView.removeSubView header
        #   setPermissionsView.removeSubView button
        #   setPermissionsView.applyExistingPermissions()

    @recursive = new KDOnOffSwitch

  createSwitches: (permission) ->
    for i in [0...9]
      @switches.push new KDOnOffSwitch
        defaultValue  : (permission & (1<<i)) != 0
        callback      : (state)=>
          @displayOctalPermissions()

  getPermissions: ->
    permissions = 0
    for s, i in @switches
      permissions |= 1<<i if s.getValue()
    return permissions

  displayOctalPermissions: ->
    @$('footer p.new em').html permissionsToOctalString(@getPermissions())

  displayOldOctalPermissions: ->
    @$('footer p.old em').html permissionsToOctalString(@getData().mode)

  viewAppended:->
    @setClass "set-permissions-wrapper"
    @applyExistingPermissions()
    super
    @$('.recursive').removeClass "hidden" if @getData().type in ['folder','multiple']

  pistachio:->
    mode = @getData().mode

    unless mode?
      """
      <header class="clearfix"><div>Unknown file permissions</div></header>
      {{> @fetchPermissionsButton}}
      """
    else
      """
      <header class="clearfix"><span>Owner</span><span>Group</span><span>Everyone</span></header>
      <aside class="permissions"><p>Read:</p><p>Write:</p><p>Execute:</p></aside>
      <section class="switch-holder clearfix">
        <div class="kdview switcher-group">
          {{> @switches[8]}}
          {{> @switches[5]}}
          {{> @switches[2]}}
        </div>
        <div class="kdview switcher-group">
          {{> @switches[7]}}
          {{> @switches[4]}}
          {{> @switches[1]}}
        </div>
        <div class="kdview switcher-group">
          {{> @switches[6]}}
          {{> @switches[3]}}
          {{> @switches[0]}}
        </div>
      </section>
      <footer class="clearfix">
        <div class="recursive hidden">
          <label>Apply to Enclosed Items</label>
          {{> @recursive}}
        </div>
        <p class="old">Old: <em></em></p>
        <p class="new">New: <em></em></p>
        {{> @setPermissionsButton}}
      </footer>
      """


  applyExistingPermissions:()->

    setPermissionsView = @
    {mode} = @getData()

    @getData().newMode = mode
    @createSwitches mode

    setTimeout =>
      @displayOctalPermissions()
      @displayOldOctalPermissions()
    , 0