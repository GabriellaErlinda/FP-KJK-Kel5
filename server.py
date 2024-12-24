from http.server import HTTPServer, SimpleHTTPRequestHandler
import socket
import datetime

class SimpleHTTPRequestHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        
        try:
            hostname = socket.gethostname()
            ip_address = socket.gethostbyname(hostname)
        except:
            hostname = "Unknown"
            ip_address = "Unknown"

        current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        
        html = f"""
        <html>
        <head>
            <title>GNS3 Test Server</title>
            <style>
                body {{ font-family: Arial, sans-serif; margin: 40px; }}
                .info {{ background: #f0f0f0; padding: 20px; border-radius: 5px; }} 
            </style>
        </head>
        <body>
            <h1>GNS3 Test Web Server</h1>
            <div class="info">
                <p><strong>Server Hostname:</strong> {hostname}</p>
                <p><strong>Server IP:</strong> {ip_address}</p>
                <p><strong>Client IP:</strong> {self.client_address[0]}</p>
                <p><strong>Request Path:</strong> {self.path}</p>
                <p><strong>Time:</strong> {current_time}</p>
            </div>
        </body>
        </html>
        """
        
        self.wfile.write(html.encode())

def run_server(port=80):
    server_address = ('', port)
    httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)
    print(f"Server running on port {port}...")
    
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nShutting down server...")
        httpd.server_close()

if __name__ == '__main__':
    run_server()
