const APIBuilder = require('@axway/api-builder-runtime');

if(process.env.APM_ENABLED) {
	console.log(`Application performance monitoring enabled. Using APM-Server: ${process.env.APM_SERVER || 'https://axway-elk-apm-server:8200'}`);
	require('elastic-apm-node').start({
		serviceName: 'MockedDemoAPIs',
		serverUrl: process.env.APM_SERVER || 'https://axway-elk-apm-server:8200', 
		verifyServerCert: false, 
		serverCaCertFile: process.env.APM_SERVER_CA || 'config/certificates/ca.crt'
	});
}

const server = new APIBuilder();

// lifecycle examples
server.on('starting', function () {
	server.logger.debug('server is starting!');
});

server.on('started', function () {
	server.logger.debug('server started!');
});

// start the server
server.start();
