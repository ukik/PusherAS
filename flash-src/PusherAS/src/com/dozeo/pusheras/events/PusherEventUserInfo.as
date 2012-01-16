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
	 * Pusher <http://pusher.com> Event Channel Data User Info Storage Object
	 * @author Tilman Griesel <https://github.com/TilmanGriesel> - dozeo GmbH <http://dozeo.com>
	 */
	public final class PusherEventUserInfo
	{
		private var _name:String;
		private var _twitter:String;
		private var _blogUrl:String;
		
		public function PusherEventUserInfo():void 
		{ 
		}
		
		public function get name():String
		{
			return this._name;
		}
		
		public function set name(value:String):void
		{
			this._name = value;
		}
		
		public function get twitter():String
		{
			return this._twitter;
		}
		
		public function set twitter(value:String):void
		{
			this._twitter = value;
		}
		
		public function get blogUrl():String
		{
			return this._blogUrl;
		}
		
		public function set blogUrl(value:String):void
		{
			this._blogUrl = value;
		}
		
		public static function parse(data:String):PusherEventUserInfo
		{
			// check if message object is null
			if(data == null)
				throw new Error('data cannot be empty');
			
			// decode data JSON string to an raw object
			var decodedObject:Object = JSON.decode(decodeURIComponent(data));
			
			// create new user info data
			var pusherEventUserInfo:PusherEventUserInfo = new PusherEventUserInfo();
			
			// parse "name" property
			if(decodedObject.hasOwnProperty('name'))
			{
				pusherEventUserInfo.name = decodedObject.name;
			}

			// parse "twitter" property
			if(decodedObject.hasOwnProperty('twitter'))
			{
				pusherEventUserInfo.twitter = decodedObject.twitter;
			}

			// parse "blogUrl" property
			if(decodedObject.hasOwnProperty('blogUrl'))
			{
				pusherEventUserInfo.blogUrl = decodedObject.blogUrl;
			}
			
			// return user info data
			return pusherEventUserInfo;
		}
		
	}
}