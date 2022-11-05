#!/usr/bin/env python3

from fastapi import  FastAPI, Request
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse, JSONResponse


app = FastAPI(
	root_path="/",
	title="TEST API",
	description="API Commands for Testing",
	version="0.0.1",
)

app.mount("/web", StaticFiles(directory="web"), name="web")



@app.get("/")
async def index():
	return FileResponse("web/index.html")

@app.post("/cosas")
async def cosas(request: Request):
	body= await request.json()
	if body is None:
		return JSONResponse(content={"error":"Faltan los datos POST","code":422})
	
	return JSONResponse(content={"message":"OK","code":200, "data":body["cosa"]})


if __name__ == "__main__":
	import uvicorn
	uvicorn.run(app, host="0.0.0.0", port=8000)
