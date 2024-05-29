from flask import Flask, request, jsonify, send_file
import requests
from flask_restx import Api, Resource, fields

app = Flask(__name__)
api = Api(app, version='1.0', title='File Download API',
          description='API for downloading files and getting client IP with Swagger documentation')

ns = api.namespace('api', description='API operations')

# Model for the download request
download_model = api.model('Download', {
    'url': fields.String(required=True, description='The URL of the file to download')
})

@ns.route('/download')
class Download(Resource):
    @api.doc('download_file')
    @api.expect(download_model)
    def post(self):
        '''Download a file from a specified URL'''
        data = request.json
        url = data.get('url')
        if not url:
            return {"error": "URL is missing"}, 400

        response = requests.get(url)
        if response.status_code == 200:
            local_filename = 'downloaded_file'
            with open(local_filename, 'wb') as file:
                file.write(response.content)
            return send_file(local_filename, as_attachment=True)

        return {"error": "Failed to download file"}, response.status_code

@ns.route('/get-ip')
class GetIP(Resource):
    @api.doc('get_client_ip')
    def get(self):
        '''Get the client IP address'''
        client_ip = request.remote_addr
        return jsonify({"client_ip": client_ip})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

