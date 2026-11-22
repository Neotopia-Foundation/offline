# Contributing

The guide is useful only while its links and facts are correct. Your help keeps it that way.

## Most useful contributions
1. **Build reports.** Build a drive with your agent. Then open an issue with the "Build report" form.
2. **Source updates.** A new national guide, a new edition, a dead link, a licence answer from a publisher. Use the "Source update" form.
3. **Bug reports.** A wrong command, a broken script, a wrong number. Use the "Bug" form.

## Rules for changes to `neotopia-offline.md`
1. **Open every link that you add.** Write the date of the check. Mark pages that block scripts with "browser".
2. **No facts from memory.** Every number, dose, frequency and emergency number needs a source that you opened.
3. **Licence first.** For each new source, write its licence. If no licence is stated, write "unclear".
4. **Short sentences.** One idea per sentence. Active voice. No semicolons. Use lists, not long enumerations in a sentence.
5. **No personal data** in examples, logs or reports.
6. Run the check before you open a pull request:
   `python3 tools/check_composer.py neotopia-offline.md`

## Languages
The guide is in English so that agents and contributors across Europe can use it. Runbooks for households are written in their own languages at build time (section 31).
