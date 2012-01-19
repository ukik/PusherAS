package com.dozeo.pusheras.auth
{
	import com.adobe.crypto.HMAC;
	import com.adobe.serialization.json.JSON;
	import com.dozeo.pusheras.events.PusherAuthenticationEvent;
	
	import flash.events.*;
	import flash.events.IEventDispatcher;
	import flash.net.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	public class PusherAuthenticator extends EventDispatcher
	{
		private var _appKey:String;
		
		public function PusherAuthenticator()
		{
		}
		
		public function authenticate(appKey:String, socketID:String, endPoint:String, channelName:String):void
		{
			this._appKey = appKey;
			
			var urlLoader:URLLoader = new URLLoader();
			var urlRequest:URLRequest = new URLRequest(endPoint);
			var postVars:URLVariables = new URLVariables();
			postVars.socket_id = socketID;
			postVars.channel_name = channelName;
			
			urlRequest.data = postVars;	
			urlRequest.method = URLRequestMethod.POST;
			
			configureListeners(urlLoader);
			
			try {
				urlLoader.load(urlRequest);
			} catch (error:Error) {
				trace("Unable to load authentication request!");
			}
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, urlLoader_COMPLETE);
			dispatcher.addEventListener(Event.OPEN, urlLoader_OPEN);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, urlLoader_PROGRESS);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, urlLoader_SECURITY_ERROR);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, urlLoader_HTTP_STATUS);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, urlLoader_IO_ERROR);
		}
		
		private function urlLoader_COMPLETE(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			
			
			if(loader.hasOwnProperty('data') == true)
			{
				var decodedData:Object = JSON.decode(loader.data);
				
				if(decodedData.hasOwnProperty('auth'))
				{
					var authString:String = _appKey + ':' + decodedData.auth;
					this.dispatchEvent(new PusherAuthenticationEvent(PusherAuthenticationEvent.SUCESSFULL, authString));	
				}
				else
					this.dispatchEvent(new PusherAuthenticationEvent(PusherAuthenticationEvent.FAILED));	
			}
			else
				this.dispatchEvent(new PusherAuthenticationEvent(PusherAuthenticationEvent.FAILED));	
		}
		
		private function urlLoader_OPEN(event:Event):void {
			//trace("openHandler: " + event);
		}
		
		private function urlLoader_HTTP_STATUS(event:HTTPStatusEvent):void {
			//trace("httpStatusHandler: " + event);
		}
		
		private function urlLoader_PROGRESS(event:ProgressEvent):void {
			//trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function urlLoader_SECURITY_ERROR(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
			this.dispatchEvent(new PusherAuthenticationEvent(PusherAuthenticationEvent.FAILED));
		}
		
		private function urlLoader_IO_ERROR(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
			this.dispatchEvent(new PusherAuthenticationEvent(PusherAuthenticationEvent.FAILED));
		}
	}
}