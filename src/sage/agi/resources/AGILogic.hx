package sage.agi.resources;

import sage.agi.helpers.AGIStringHelper;

// TODO: AGILogic needs to be cleaned up and documented
class AGILogic {
	public var logicData:Array<Int> = new Array<Int>();

	private var messages:Array<String> = new Array<String>();

	public function new(file:AGIFile) {
		extractLogicCode(file);
		loadMessages(file);
	}

	private function extractLogicCode(file:AGIFile) {
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

	private function loadMessages(file:AGIFile) {
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

	// public var logicIndex:Int;
	// public var nextByte(get, null):Int;
	// private function get_nextByte() {
	// 	return logicData[logicIndex++];
	// }
	// public var nextSingle(get, null):Int;
	// private function get_nextSingle() {
	// 	var b1 = logicData[logicIndex++];
	// 	var b2 = logicData[logicIndex++];
	// 	// return (b2 << 8) | (b1 /*& 0xff*/);
	// 	return 256 * b1 + b2;
	// }
	// public var tell(get, null):Int;
	// private function get_tell():Int {
	// 	return logicData[logicIndex];
	// }
}
