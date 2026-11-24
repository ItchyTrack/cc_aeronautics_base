function add_modem_wrap(modem)
	function modem.wrap(name)
		if not modem.isPresentRemote(name) then
			return nil
		end

		local methods = modem.getMethodsRemote(name)
		local proxy = {}

		for _, method in ipairs(methods) do
			proxy[method] = function(...)
				return modem.callRemote(name, method, ...)
			end
		end

		return proxy
	end
end