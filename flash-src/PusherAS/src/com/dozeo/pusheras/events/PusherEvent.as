// Copyright (c) 2012 dozeo GmbH
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

package com.dozeo.pusheras.events
{
	import com.adobe.serialization.json.JSON;

	/**
	 * Pusher <http://pusher.com> Base Event
	 * @author Tilman Griesel <https://github.com/TilmanGriesel> - dozeo GmbH <http://dozeo.com>
	 */
	public final class PusherEvent
	{
		private var _event:String;
		private var _message:String;
		private var _code:int;
		private var _socket_id:Number;	
		private var _data:PusherEventData;
		
		public function PusherEvent():void 
		{ 
		}
		
		public function get event():String
		{
			return this._event;
		}
		
		public function set event(value:String):void
		{
			this._event = value;
		}
		
		public function get message():String
		{
			return this._message;
		}
		
		public function set message(value:String):void
		{
			this._message = value;
		}
		
		public function get code():int
		{
			return this._code;
		}
		
		public function set code(value:int):void
		{
			this._code = value;
		}

		public function get socket_id():Number
		{
			return this._code;
		}
		
		public function set socket_id(value:Number):void
		{
			this._code = value;
		}
		
		public function get data():PusherEventData
		{
			return this._data;
		}
		
		public function set data(value:PusherEventData):void
		{
			this._data = value;
		}
		
		public static function parse(data:String):PusherEvent
		{
			// check if message object is null
			if(data == null)
				throw new Error('data cannot be empty');
			
			// decode data JSON string to an raw object
			var decodedObject:Object = JSON.decode(decodeURIComponent(data));
			
			// create new pusher event
			var pusherEvent:PusherEvent = new PusherEvent();
			
			// parse "event" property
			if(decodedObject.hasOwnProperty('event'))
			{
				pusherEvent.event = decodedObject.event;
			}
			else
			{
				throw new Error('cannot find "event" property!');
			}
			
			// parse "data" property
			if(decodedObject.hasOwnProperty('data'))
			{
				pusherEvent.data = PusherEventData.parse(decodedObject.data);
			}
			
			// parse "code" property
			if(decodedObject.hasOwnProperty('code'))
			{
				pusherEvent.code = decodedObject.code;
			}

			// parse "socket_id" property
			if(decodedObject.hasOwnProperty('socket_id'))
			{
				pusherEvent.socket_id = decodedObject.socket_id;
			}
			
			// return pusher event
			return pusherEvent;
		}
		
		/**
		 * get JSON encoded string
		 * */
		public function json():String
		{
			var eventString:String = JSON.encode(this);
			return eventString;
		}
		
	}
}