/// Normalizes a [DateTime] to a UTC midnight instant representing only its
/// calendar date (year/month/day). Using UTC avoids off-by-one-hour and
/// off-by-one-day bugs when doing day arithmetic (`add`/`subtract`/
/// `difference`) across daylight saving time transitions in the local
/// timezone.
DateTime dateOnly(DateTime date) => DateTime.utc(date.year, date.month, date.day);
