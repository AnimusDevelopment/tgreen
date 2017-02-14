#define SMILE_DELIMITER ":"
var/regex/regexSmile = regex("[SMILE_DELIMITER](.*?)[SMILE_DELIMITER]", "g")
var/list/emojis = icon_states('icons/emoji.dmi')
var/list/kappas = icon_states('icons/twitchsmiles.dmi')

/proc/replaceIfExist(rawText, finishedText)
	if(finishedText in emojis)      return "<img class=icon src=\ref['icons/emoji.dmi'] iconstate='[finishedText]'>"
	else if(finishedText in kappas) return "<img class=icon src=\ref['icons/twitchsmiles.dmi'] iconstate='[finishedText]'>"
	else                            return rawText
#undef SMILE_DELIMITER




/proc/smile_parse(text)
	if(!config.emojis)
		return text
	return regexSmile.Replace(text, /proc/replaceIfExist)
