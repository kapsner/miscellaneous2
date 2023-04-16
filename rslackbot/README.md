# How to configure slackbot for use with R

See:  

* [https://github.com/mrkaye97/slackr](https://github.com/mrkaye97/slackr)
* [https://cran.r-project.org/web/packages/slackr/vignettes/webhook-setup.html](https://cran.r-project.org/web/packages/slackr/vignettes/webhook-setup.html)

## Install `slackr`


```R
install.packages("slackr")
```

## Setup Web Hook Bot

* Go to [https://api.slack.com/apps](https://api.slack.com/apps) and create new app
* Click "Create An App" > "From scratch"
* Define app name, pick workspace and click "Create App"
* From "Add features and functionality" select "Incoming Webhooks" and activate it
  + click "Add New Webhook to Workspace"
  + select channel to which app should post and click "Allow"
* Now copy the webhook url
* To allow posting of files, go to the menu and select "OAuth & Permissions"
  + copy the "Bot User OAuth Token" from "OAuth Tokens for Your Workspace"
  + go down to "Scopes > Bot Token Scopes" and click "Add an OAuth Scope"
  + select "files:write" and click "Reinstall your app", select channel again and click "Allow"
* Finally, for the bot to be really able to post files to the channel, you need to invite it: type into the channel `/invite @appname`

## Configurations

Adapt the [slackr.conf](slackr.conf) accordingly.

## Use from within R

```R
# connect
slackr::slackr_setup(config_file = "slackr.conf")

# write message to channel
slackr::slackr_bot("Hello")
 
# upload file
slackr::slackr_upload(filename = "/path/to/file.pdf")
```
