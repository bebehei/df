x() {
	for zipfile in $*; do
		local extractor
		if [ -f "$zipfile" ]; then
			case "$zipfile" in
				*.tar.lrz)
					extractor="lrztar -d" ;;
				*.lrz)
					extractor="lrunzip" ;;
				*.tar.bz2)
					extractor="bsdtar xjf" ;;
				*.bz2)
					extractor="bunzip2" ;;
				*.tar.gz)
					extractor="bsdtar xzf" ;;
				*.gz)
					extractor="gunzip" ;;
				*.tar.xz)
					extractor="bsdtar Jxf" ;;
				*.xz)
					extractor="xz -d" ;;
				*.rar)
					extractor="unrar e" ;;
				*.tar)
					extractor="bsdtar xf" ;;
				*.tbz2)
					extractor="bsdtar xjf" ;;
				*.tgz)
					extractor="bsdtar xzf" ;;
				*.zip)
					extractor="unzip" ;;
				*.Z)
					extractor="uncompress" ;;
				*.7z)
					extractor="7z x" ;;
				*)
					echo "Cannot extract '$zipfile': No extractor for filetype known ..." >&2
					return 1
					;;
			esac

			if ! command -v `echo $extractor | awk '{print $1}'` >/dev/null 2>/dev/null; then
				echo "Cannot extract '$zipfile': Cannot find extractor '`echo $extractor | awk '{print $1}'`'." >&2
				return 1
			fi

			echo "Extracting '$zipfile'..." >&2
			eval $extractor $zipfile

		elif [ ! -e "$zipfile" ]; then
			echo "Cannot extract '$zipfile': File does not exist!"
			return 1
		else
			echo "Cannot extract '$zipfile': Not a valid file!"
			return 1
		fi
	done
}
