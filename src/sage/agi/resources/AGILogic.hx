package sage.agi.resources;

import sage.agi.helpers.AGIStringHelper;

class AGILogic extends Resource {
	@:isVar public var logicData(default, set):Array<Int> = new Array<Int>();

	private function set_logicData(value) {
		return logicData = value;
	}

	private var messages:Array<String> = new Array<String>();

	public function new(file:AGIFile, resourceID:Int) {
		super(file, resourceID);
		extractLogicCode();
		loadMessages();
	}

	private function extractLogicCode() {
		if (file.data.length > 0) {
			var codeSize = file.data[0] + (file.data[1] << 8);
			if (codeSize > 1) {
				file.data.slice(2, codeSize + 2).map(function(v) {
					logicData.push(v);
					return v;
				});
			}
		}
	}

	private function loadMessages() {
		var msgSectionStart = file.data[0] + (file.data[1] << 8) + 2;
		var msgSectionEnd = file.data[msgSectionStart + 1] + (file.data[msgSectionStart + 2] << 8);
		var msgCount = file.data[msgSectionStart];
		msgSectionStart += 3; // The messages start after the message section header

		// Decrypt the message section
		var msgHeaderLength = msgCount * 2; // message indexes are two bytes each
		var dataPosStart = msgSectionStart + msgHeaderLength;
		var dataPosEnd = msgSectionStart + msgSectionEnd - 2;
		AGIEncryption.decryptArray(file.data, dataPosStart, dataPosEnd);

		var message = 0;
		while (message < msgCount) {
			var msgIndex = file.data[msgSectionStart + message * 2] + (file.data[msgSectionStart + message * 2 + 1] << 8) - 2;
			messages[message] = AGIStringHelper.getString(file.data, msgSectionStart + msgIndex);
			
			message++;
		}
	}

	public function getMessage(index:Int):String {
		return messages[index];
	}
}
