import asyncio
import websockets
import json

calibration_map = dict()

# 192.168.1.118
# ("None", "green", "red", "blue", "yellow")
color_dict = {
    0: "None",
    1: "green",
    2: "red",
    3: "blue",
    4: "yellow"
}

async def main():

    #'ws://127.0.0.1:4000/sequencersocket/websocket'
    #'ws://sequencerinterface.local:4000/sequencersocket/websocket'
    async with websockets.connect('ws://sequencerinterface.local:4000/sequencersocket/websocket') as websocket:
        await websocket.send(json.dumps({
                    "event":"phx_join",
                    "topic":"sequencer:lobby",
                    "payload": {},
                    "ref": "sequencers:one"}
        ))

        while True:
            response = await websocket.recv()
            json_response = json.loads(response)

            if json_response["event"] == "updated_sequencerpad":
                payload = json_response["payload"]
                calibration_map[payload["padid"]] = payload["color"]
                print(json_response["payload"])
                await websocket.send(json.dumps({
                    "event": "sequencer_feedback",
                    "topic": "sequencer:lobby",
                    "payload": json_response["payload"],
                    "ref": ""}
                ))
            elif json_response["event"] == "clear":
                calibration_map.clear()
            elif json_response["event"] == "calibrate":
                print("calibrate")
                payload = json_response["payload"]
                print(payload)
                await websocket.send(json.dumps({
                    "event": "shout",
                    "topic": "sequencer:lobby",
                    "payload": {"msg": "Calibration successful!!!"},
                    "ref": "sequencers:one"}
                ))


loop = asyncio.run(main())
try:
    asyncio.ensure_future(main())
    loop.run_forever()
except KeyboardInterrupt:
    pass
finally:
    print("Closing Loop")
    loop.close()

