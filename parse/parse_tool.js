var https = require('https');

var args = process.argv.slice(2);



var convoID = args[0]
var access_token = args[1]

var p = '/v2.3/' + convoID + '?fields=to%2Ccomments.limit(1000)&access_token=' + access_token

var o = {
  host: 'graph.facebook.com',
  path: p,
  method: 'GET'
};

var convo = []
var threads_parsed = 0

function getTestPersonaLoginCredentials(callback, options) {

    return https.get(options, function(response) {
        // Continuously update stream with data
        var body = '';
        response.on('data', function(d) {
            body += d;
        });
        response.on('end', function() {
            // Data reception is done, do whatever with it!
            var parsed = JSON.parse(body);
            if (parsed.error){
                console.log(parsed.error)
                return
            }

            callback(parsed);
            
        });
    })
    .on('error', (e) => {
  		console.error(e);
	})
}

function callback_fn(parsed) {
	console.log("============================")

	for (var i = 0; i<parsed.comments.data.length; i++){
		var sender = parsed.comments.data[i].from.id

		m = {
			"sender_id": sender,
			"thread_id": convoID,
			"text": parsed.comments.data[i].message,
			"timestamp": parsed.comments.data[i].created_time
		}

		convo.push(m)
	}
	o = parsed.comments.paging.next
	console.log(convo.length)
}

for (threads_parsed = 0; threads_parsed < 10; threads_parsed++ ){
	getTestPersonaLoginCredentials(callback_fn,o);
}

