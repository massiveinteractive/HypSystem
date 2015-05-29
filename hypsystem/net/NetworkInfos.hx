package hypsystem.net;

#if msignal
import msignal.Signal;
#end

@:build(ShortCuts.mirrors())
class NetworkInfos
{

	#if msignal
	public static var onConnectivityChanged:Signal0 = new Signal0();
	#else
	public static var onConnectivityChanged:Void->Void;
	#end

	public static function listen():Void
	{
		setListener(onStatusChanged);
		listenForChanges();
	}
	
	@JNI 
	@IOS("hyp-system","hypsystem_networkinterface_isConnected")
	public static function isConnected():Bool
	{
		return false;
	}

	public static function getConnectionType():ConnectionType
	{
		var type = 0;
		var result:ConnectionType = ConnectionType.NONE;
		try
		{
			#if(android || ios)
			type = getActiveConnectionType();	
			#end

			switch (type)
			{
				case 1:
					result = ConnectionType.WIFI;

				case 2:
					result = ConnectionType.MOBILE;

				case _:
			}

			trace("result = " + result);
		}
		catch (error:Dynamic)
		{
			trace(error);
		}
		return result;
	}

	static function onStatusChanged():Void
	{
		trace("nStatus changed");
		#if msignal
		if (onConnectivityChanged != null)
		{
			onConnectivityChanged.dispatch();
		}
		#else
		if (onConnectivityChanged != null)
		{
			onConnectivityChanged();
		}
		#end
	}

	@JNI 
	@IOS("hyp-system","hypsystem_networkinterface_isWifi")
	public static function isWifi():Bool
	{
		return false;
	}

	@JNI
	@IOS("hyp-system","hypsystem_networkinterface_connectionType")
	static function getActiveConnectionType():Int
	{
		return 0;
	}	
	
	@JNI 
	@IOS("hyp-system","hypsystem_networkinterface_listen")
	static function listenForChanges():Void{}
	

	@CPP("hypsystem","hypsystem_setEventListener")
	static function setListener(f:Void->Void):Void{}
}

enum ConnectionType
{
	NONE;
	WIFI;
	MOBILE;
}
