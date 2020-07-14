{ config, pkgs, ... }:
{
	programs.taskwarrior = {
		enable = true;
		#colorTheme = "";
		config = {
			uda.reviewed.type = "date";
			uda.reviewed.label = "Reviewed";
			report._reviewed.description = "Tasksh review report.  Adjust the filter to your needs.";
			report._reviewed.columns = "uuid";
			report._reviewed.sort = "reviewed+,modified+";
			report._reviewed.filter = "( reviewed.none: or reviewed.before:now-6days ) and ( +PENDING or +WAITING )";
			uda.priority.values = "H,M,,L";
		};
	};
}
