curl -X POST \
-H 'Content-Type:application/json' \
-H 'Authorization: Bearer {a+1xHPUmQpdTUJxYkYo7dDT5Inv1n3S+c1tVTNTtk0gJxUCwjZlu3V9i1GJPcXMK1lbFtJgtr132ZCV4+1lFAea9nZdTUXZu6TUlTaX0Xp8IbgBdqqapLb1BF12NlyRhU1xlbczxDvedQI5ixiu6wgdB04t89/1O/w1cDnyilFU=}' \
-d '{
    "to": "Uc7b4ca22a0b6c4f49902a7a5cbbf88b1",
    "messages":[
        {
        "type": "text",
        "text": "ままん\n駐車場代を振り込まないと"
    }
    ]
}' https://api.line.me/v2/bot/message/push
