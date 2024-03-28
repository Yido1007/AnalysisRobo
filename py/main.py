from flask import Flask
from flask_restful import Api, Resource, reqparse, request
import lib


app = Flask(__name__)
api = Api(app)

class Analysis(Resource):
    def get(self):
        symbol = request.args.get('symbol', default = "TCELL.IS", type = str)
        result = lib.doAnalysis(symbol)
        return {'result' : "successfull", "image": result}, 200
    

api.add_resource(Analysis, '/analysis')


if __name__ == '__main__':
    # app.run(host="0.0.0.0", port=5000)
    app.run()