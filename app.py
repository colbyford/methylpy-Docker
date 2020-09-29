import os
from flask import Flask, flash, request, redirect, url_for, jsonify
from werkzeug.utils import secure_filename

UPLOAD_FOLDER = '/uploads/'
ALLOWED_EXTENSIONS = {'txt', 'csv', 'fastq'}

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/', methods=['GET'])
def base_url():
    """Base url to test API."""

    response = {
        'response': 'Welcome to methylpy!'
    }

    return jsonify(response)

@app.route('/methylpy')
def run_methylpy():
	## http://127.0.0.1:5000/methylpy?input=/raw/&output=/processed/&pipeline=paired-end-pipeline
	input_path = request.args.get('input') #if key doesn't exist, returns None
	output_path = request.args.get('output') #if key doesn't exist, returns None
	pipeline = request.args['pipeline'] #if key doesn't exist, returns a 400, bad request error

	return '''<h1>Welcome to methylpy!</h1>
			<h2>The input path is: {}</h2>
			<h2>The framework value is: {}</h2>
			<h2>The pipeline to run is: {}</h2>'''.format(input_path, output_path, pipeline)


# def allowed_file(filename):
    # return '.' in filename and \
           # filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# @app.route('/', methods=['GET', 'POST'])
# def upload_file():
    # if request.method == 'POST':
        # # check if the post request has the file part
        # if 'file' not in request.files:
            # flash('No file part')
            # return redirect(request.url)
        # file = request.files['file']
        # # if user does not select file, browser also
        # # submit an empty part without filename
        # if file.filename == '':
            # flash('No selected file')
            # return redirect(request.url)
        # if file and allowed_file(file.filename):
            # filename = secure_filename(file.filename)
            # file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            # return redirect(url_for('uploaded_file',
                                    # filename=filename))
    # return '''
    # <!doctype html>
    # <title>Upload new File</title>
    # <h1>Upload new File</h1>
    # <form method=post enctype=multipart/form-data>
      # <input type=file name=file>
      # <input type=submit value=Upload>
    # </form>
    # '''

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
