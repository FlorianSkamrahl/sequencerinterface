import asyncio
import websockets
import json

calibration_map = dict()

async def main():

    async with websockets.connect('ws://127.0.0.1:4000/sequencersocket/websocket') as websocket:
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
                print(calibration_map)
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

