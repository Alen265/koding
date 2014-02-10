fs = require 'fs'
nodePath = require 'path'
deepFreeze = require 'koding-deep-freeze'

version = (fs.readFileSync nodePath.join(__dirname, '../VERSION'), 'utf-8').trim()
projectRoot = nodePath.join __dirname, '..'

mongo        = 'dev:k9lc4G1k32nyD72@172.16.3.9:27017/koding'
mongoKontrol = 'dev:k9lc4G1k32nyD72@172.16.3.9:27017/kontrol'

mongoReplSet = 'mongodb://dev:k9lc4G1k32nyD72@172.16.3.9,172.16.3.10,172.16.3.3/koding?replicaSet=koodingrs0&readPreference=primaryPreferred'

socialQueueName = "koding-social-#{version}"

authExchange    = "auth-#{version}"
authAllExchange = "authAll-#{version}"

embedlyApiKey   = '94991069fb354d4e8fdb825e52d4134a'

environment     = "sjc-production"
regions         =
  vagrant       : "vagrant"
  sj            : "sj"
  aws           : "aws"

module.exports =
  environment   : environment
  regions       : regions
  version       : version
  aws           :
    key         : 'AKIAJSUVKX6PD254UGAA'
    secret      : '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'
  uri           :
    address     : "https://koding.com"
  userSitesDomain: 'kd.io'
  containerSubnet: "10.128.2.0/9"
  vmPool        : "vms"
  projectRoot   : projectRoot
  webserver     :
    useCacheHeader: yes
    login       : 'prod-webserver'
    port        : 3000
    clusterSize : 1
    queueName   : socialQueueName+'web'
    watch       : no
  sourceServer  :
    enabled     : no
    port        : 1337
  neo4j         :
    read        : "http://kgraph.sj.koding.com"
    write       : "http://kgraph.sj.koding.com"
    port        : 7474
  mongo         : mongo
  mongoKontrol  : mongoKontrol
  mongoReplSet  : mongoReplSet
  runNeo4jFeeder: yes
  runGoBroker   : no
  runGoBrokerKite : no
  runKontrol    : yes
  runRerouting  : yes
  runUserPresence: yes
  runPersistence: yes
  compileGo     : no
  buildClient   : yes
  runOsKite     : no
  runProxy      : no
  redis         : "172.16.3.13:6379"
  misc          :
    claimGlobalNamesForUsers: no
    updateAllSlugs : no
    debugConnectionErrors: yes
  uploads       :
    enableStreamingUploads: yes
    distribution: 'https://d2mehr5c6bceom.cloudfront.net'
    s3          :
      awsAccountId        : '616271189586'
      awsAccessKeyId      : 'AKIAJO74E23N33AFRGAQ'
      awsSecretAccessKey  : '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'
      bucket              : 'koding-uploads'
  loggr:
    push: yes
    url: "http://post.loggr.net/1/logs/koding/events"
    apiKey: "eb65f620b72044118015d33b4177f805"
  librato :
    push      : no
    email     : ""
    token     : ""
    interval  : 60000
  # loadBalancer  :
  #   port        : 3000
  #   heartbeat   : 5000
    # httpRedirect:
    #   port      : 80 # don't forget port 80 requires sudo
  bitly :
    username  : "kodingen"
    apiKey    : "R_677549f555489f455f7ff77496446ffa"
  authWorker    :
    authExchange: authExchange
    authAllExchange: authAllExchange
    login       : 'prod-authworker'
    queueName   : socialQueueName+'auth'
    numberOfWorkers: 2
    watch       : yes
  emailConfirmationCheckerWorker :
    enabled              : yes
    login                : 'prod-social'
    queueName            : socialQueueName+'emailConfirmationCheckerWorker'
    numberOfWorkers      : 1
    watch                : yes
    cronSchedule         : '00 * * * * *'
    usageLimitInMinutes  : 60
  elasticSearch          :
    host                 : "localhost"
    port                 : 9200
    enabled              : no
    queue                : "elasticSearchFeederQueue"
  guestCleanerWorker     :
    enabled              : no # for production, workers are running as a service
    login                : 'prod-social'
    queueName            : socialQueueName+'guestcleaner'
    numberOfWorkers      : 1
    watch                : yes
    cronSchedule         : '00 * * * * *'
    usageLimitInMinutes  : 60
  sitemapWorker          :
    enabled              : yes
    login                : 'prod-social'
    queueName            : socialQueueName+'sitemapworker'
    numberOfWorkers      : 2
    watch                : yes
    cronSchedule         : '00 00 00 * * *'
  topicModifier          :
    cronSchedule         : '0 */5 * * * *'
  graphFeederWorker:
    numberOfWorkers: 4
  social        :
    login       : 'prod-social'
    numberOfWorkers: 7
    watch       : no
    queueName   : socialQueueName
    verbose     : no
  cacheWorker   :
    login       : 'prod-social'
    watch       : no
    queueName   : socialQueueName+'cache'
    run         : no
  presence        :
    exchange      : 'services-presence'
  client          :
    version       : version
    watch         : no
    watchDuration : 300
    includesPath  : 'client'
    indexMaster   : "index-master.html"
    index         : "default.html"
    useStaticFileServer: no
    staticFilesBaseUrl: "https://koding.com"
    runtimeOptions:
      environment        : environment
      activityFetchCount : 20
      precompiledApi     : yes
      authExchange       : authExchange
      github        :
        clientId    : "5891e574253e65ddb7ea"
      embedly        :
        apiKey       : embedlyApiKey
      userSitesDomain: 'kd.io'
      useNeo4j: yes
      logToExternal : yes
      resourceName: socialQueueName
      suppressLogs: yes
      version   : version
      mainUri   : "http://koding.com"
      broker    :
        servicesEndpoint: "/-/services/broker"
        sockJS   : "https://broker-#{version}.koding.com/subscribe"
      brokerKite:
        servicesEndpoint: "/-/services/broker"
        brokerExchange: 'brokerKite'
        sockJS   : "https://brokerkite-#{version}.koding.com/subscribe"
      apiUri    : 'https://koding.com'
      appsUri   : 'https://koding-apps.s3.amazonaws.com'
      uploadsUri: 'https://koding-uploads.s3.amazonaws.com'
      sourceUri : "http://webserver-#{version}a.sj.koding.com:1337"
      newkontrol:
        url     : 'wss://newkontrol.sj.koding.com:80/dnode'
      fileFetchTimeout: 15 * 1000 # seconds
      externalProfiles  :
        github          :
          nicename      : 'GitHub'
          urlLocation   : 'html_url'
        odesk           :
          nicename      : 'oDesk'
          urlLocation   : 'info.profile_url'
        facebook        :
          nicename      : 'Facebook'
          urlLocation   : 'link'
        google          :
          nicename      : 'Google'
        linkedin        :
          nicename      : 'LinkedIn'
        twitter         :
          nicename      : 'Twitter'
        # bitbucket     :
        #   nicename    : 'BitBucket'
  mq            :
    host        : '172.16.3.5'
    port        : 5672
    apiAddress  : "172.16.3.5"
    apiPort     : 15672
    login       : 'guest'
    componentUser: "guest"
    password    : 'Xah8ibeekelah'
    heartbeat   : 20
    vhost       : 'new'
  broker        :
    name        : "broker"
    ip          : ""
    port        : 443
    certFile    : "/opt/ssl_certs/wildcard.koding.com.cert"
    keyFile     : "/opt/ssl_certs/wildcard.koding.com.key"
    webProtocol : 'https:'
    webHostname : "broker-#{version}a.koding.com"
    webPort     : null
    authExchange: authExchange
    authAllExchange: authAllExchange
  brokerKite    :
    name        : "brokerKite"
    ip          : ""
    port        : 443
    certFile    : "/opt/ssl_certs/wildcard.koding.com.cert"
    keyFile     : "/opt/ssl_certs/wildcard.koding.com.key"
    webProtocol : 'https:'
    webHostname : "brokerkite-#{version}a.koding.com"
    webPort     : null
    authExchange: authExchange
    authAllExchange: authAllExchange
  kites:
    disconnectTimeout: 3e3
    vhost       : 'kite'
  email         :
    host        : "koding.com"
    protocol    : 'https:'
    defaultFromAddress: 'hello@koding.com'
  emailWorker   :
    cronInstant : '*/10 * * * * *'
    cronDaily   : '0 10 0 * * *'
    run         : no
    forcedRecipient : undefined
  emailSender   :
    run         : no
  guests        :
    # define this to limit the number of guset accounts
    # to be cleaned up per collection cycle.
    poolSize        : 1e4
    batchSize       : undefined
    cleanupCron     : '*/10 * * * * *'
  pidFile       : '/tmp/koding.server.pid'
  haproxy:
    webPort     : 3020
  newkontrol      :
    host          : "kontrol-internal.sj.koding.com"
    port          : 4000
    certFile      : "/opt/koding/go/src/koding/kontrol/kontrolproxy/files/10.0.5.231_cert.pem"
    keyFile       : "/opt/koding/go/src/koding/kontrol/kontrolproxy/files/10.0.5.231_key.pem"
  proxyKite       :
    domain        : "x.koding.com"
    certFile      : "/opt/koding/go/src/koding/kontrol/kontrolproxy/files/10.0.5.102_cert.pem"
    keyFile       : "/opt/koding/go/src/koding/kontrol/kontrolproxy/files/10.0.5.102_key.pem"
  etcd            : [ {host: "127.0.0.1", port: 4001} ]
  kontrold        :
    vhost         : "/"
    overview      :
      apiHost     : "172.16.3.11"
      apiPort     : 80
      port        : 8080
      switchHost  : "koding.com"
    api           :
      port        : 80
      url         : "http://kontrol0.sj.koding.com"
    proxy         :
      port        : 80
      portssl     : 443
      ftpip       : '54.208.3.200'
  recurly       :
    apiKey      : '0cb2777651034e6889fb0d091126481a' # koding.recurly.com
  embedly       :
    apiKey      : embedlyApiKey
  opsview	:
    push	: yes
    host	: 'opsview.in.koding.com'
    bin   : '/usr/local/nagios/bin/send_nsca'
    conf  : '/usr/local/nagios/etc/send_nsca.cfg'
  followFeed    :
    host        : '172.16.3.4'
    port        : 5672
    componentUser: 'guest'
    password    : 'Xah8ibeekelah'
    vhost       : 'followfeed'
  github        :
    clientId    : "5891e574253e65ddb7ea"
    clientSecret: "9c8e89e9ae5818a2896c01601e430808ad31c84a"
  odesk          :
    key          : "9ed4e3e791c61a1282c703a42f6e10b7"
    secret       : "1df959f971cb437c"
    request_url  : "https://www.odesk.com/api/auth/v1/oauth/token/request"
    access_url   : "https://www.odesk.com/api/auth/v1/oauth/token/access"
    secret_url   : "https://www.odesk.com/services/api/auth?oauth_token="
    version      : "1.0"
    signature    : "HMAC-SHA1"
    redirect_uri : "https://koding.com/-/oauth/odesk/callback"
  facebook       :
    clientId     : "434245153353814"
    clientSecret : "84b024e0d627d5e80ede59150a2b251e"
    redirectUri  : "https://koding.com/-/oauth/facebook/callback"
  google         :
    client_id    : "134407769088.apps.googleusercontent.com"
    client_secret: "6Is_WwxB19tuY2xkZNbnAU-t"
    redirect_uri : "https://koding.com/-/oauth/google/callback"
  statsd         :
    use          : true
    ip           : "172.168.2.7"
    port         : 8125
  graphite       :
    use          : true
    host         : "172.168.2.7"
    port         : 2003
  linkedin       :
    client_id    : "aza9cks1zb3d"
    client_secret: "zIMa5kPYbZjHfOsq"
    redirect_uri : "https://koding.com/-/oauth/linkedin/callback"
  twitter        :
    key          : "tvkuPsOd7qzTlFoJORwo6w"
    secret       : "48HXyTkCYy4hvUuRa7t4vvhipv4h04y6Aq0n5wDYmA"
    redirect_uri : "https://koding.com/-/oauth/twitter/callback"
    request_url  : "https://twitter.com/oauth/request_token"
    access_url   : "https://twitter.com/oauth/access_token"
    secret_url   : "https://twitter.com/oauth/authenticate?oauth_token="
    version      : "1.0"
    signature    : "HMAC-SHA1"
  mixpanel       : "d35a8d0b14e284f32ab5380590c6848a"
  rollbar        : "cc4daee549e3405e9e139d34c5bce45b"
  slack          :
    token        : "xoxp-2155583316-2155760004-2158149487-a72cf4"
    channel      : "C024LG80K"
  logLevel        :
    neo4jfeeder   : "info"
    oskite        : "info"
    kontrolproxy  : "debug"
    userpresence  : "info"
    vmproxy       : "info"
    graphitefeeder: "info"
    sync          : "info"
    topicModifier : "info"
    postModifier  : "info"
    router        : "info"
    rerouting     : "info"
    overview      : "info"
    amqputil      : "info"
    rabbitMQ      : "info"
    ldapserver    : "info"
    broker        : "info"
