#!/bin/bash

curl -X POST --data-urlencode "payload={\"text\": \"SSL証明書を更新しました。\n詳細は以下のとおりです。\n\" }" <webhook url> &&
sudo /usr/bin/certbot certificates | xargs -I {} curl -X POST --data-urlencode "payload={\"text\": \"{}\n\" }" <webhook url> &&
sudo certbot renew | xargs -I {} curl -X POST --data-urlencode "payload={\"text\": \"{}\n\" }" <webhook url> &&
sudo /usr/bin/certbot certificates | xargs -I {} curl -X POST --data-urlencode "payload={\"text\": \"{}\n\" }" <webhook url>

