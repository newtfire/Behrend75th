##  Review of the Paul Siple Letter to Mr. Behrend project

* Site publication: <https://digit-110.github.io/Digit-110-Project/>
* GitHub: <https://github.com/Digit-110/Digit-110-Project>
* Developers: Graesyn Tefft, Sam Deeter, Harrison Lilley
* Date of Evaluation: 2021-12-19
* Evaluated by: @ebeshero

### General  
This team produced an impressive looking website to feature the historic document you worked with, the letter from antarctic explorer Paul Siple to Ernst Behrend. The CSS and JavaScript effects on the reading view page make it an interactive experience with the magnifying glass effect and the drop-down displays of information that appear on mouse-over. Sam's Javascript adventures made a strong contribution to this project. However, we are missing some fundamental things expected of our projects this semester, like:
* a Creative Commons license indicating how you are sharing your work and what they are licensed to do with it,
* a link to the GitHub repo to share your code

Apparently there were some uncertainties over which files were the official ones to generate and apply for display on the website, as documented below. Some of these issues could have been cleared up with documentation if you could rely on each other to read Slack messages or follow an issue you post on GitHub repo to help you remember things you probably discussed during team meetings. I see several signs of confusion over project files that affected the representation of the Paul Siple letter on your project website. 

### XSLT and HTML Reading View
There's a strange mismatch between the XSLT file that produces HTML found in your GitHub repo, and the transcription that I see on your website. The HTML files are coded differently, which makes me wonder if there was some miscommunication about the files in use for your website. For one thing, the HTML file in your output uses `<p>` elements and `<meta>` elements with a `<div>` containing the image of the penguin at the bottom. That is not what is being displayed on the website. The file shown there is outputting paragraphs oddly using an unordered list with the pargraphs in `<li>` elements. Using the `<p>` elements would have been a better call for accessibility: it doesn't make much sense to output paragraphs as list items, particularly since you then have to do a workaround in your CSS to hide the bullet points and force the list items to display like paragraphs. 

You wouldn't really want the `<meta>` elements either, though. Those can simply be changed to `<p>` elements to make for valid HTML. One problem with the XSLT I see in your project repo is simply that it is missing the `<xsl:output>` line that indicates you are generating an XHTML file. That `<xsl:output>` line would have generated the official DOCTYPE and namespace you need for the HTML to behave properly with your CSS and JavaScript. The line you are missing in that XSLT is simply this, which you can find in your homework assignments for XSLT to HTML: 

```xml
<xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
```

### Errata: (Repairs to make in the XML)

There are many pretty serious errors with the transcription of your letter, including a long-ish passage that seems to be missing in your XML encoding:

* Paul Siple's name is misspelled as PAUL A. SPILE in your transcription of the letterhead. 
* The address is incorrectly transcribed as "FITH STREET" when it should be "FIFTH STREET".
* At the end of the first paragraph, there's a passage you've marked as a `<location>`, only you've missed some of the words in it. You have: "an extinct valcano, Mt. Raymond Fosdick in the Marie Byrd Land, Antarctica." 
   
    * What you should have is:

```
an extinct volcano, Mt. Raymond Fosdick
in the Edsel Ford Mountain Range of the northern 
Marie Byrd Land, Antarctica.
```
* You are missing a whole line of text in the second paragraph, where you have: 
"our party travel-ling by dog team during October - December, was composed of four men "

    * Here's what you should have at that point: 

```
our party travel-ling by dog team during October—December,
1934. The Marie Byrd Land sledging party
was composed of four men
```
* The last sentence of that paragraph ends with a period in the image.
* In the third paragraph you're missing multiple whole lines in your transcript. Where you have: 
"Thanksgiving Day near the point that blew almost continuosly
for three miles an hour"

    * What you should have is a lot different (the wind is quite a bit stronger!):

```
Thanksgiving Day near the point
where this rock was picked up in a blizzard
that blew almost continuously for three
days at a velocity rarely below thirty five
miles an hour
```
* In the last paragraph, you have: "and I returned it to you" but it should read:

```
and I return it to you
```

* Since you've been preserving the hyphenation at the ends of lines, you should have `it-self.`, instead of "itself." as the last word of the last paragraph.

* In the close of the letter, you have "Sincerly yours," but the letter actually reads `Sincerely yours,`

We wish the transcription work had been done more carefully! This is why we asked each team to appoint a Quality Control Manager to double-check things like skipped lines. A few of these errors are understandable, but missing so much of a short typescript letter really indicates that something fell through the cracks for this team in checking your work. 

I hope that one of you will make corrections, but if not it will have to be a future student researcher or project team. How should corrections be made? **Make it a policy to always correct the XML**, and re-run the XSLT. The XML is designed to outlast the web display of the data, and you or some other student coder might decide one day to totally overhaul the way you display it. 

I notice on inspecting your GitHub repo that Graesyn *did* correct a couple of the long errors on an HTML page that is *not linked from the navigation menu of your website*: Graesyn's corrections were made to the HTML file `breakdown.html` rather than to the page actually linked, `transcription.html`. This raises a couple of team project and file management issues:

1. To prevent confusions like this, you should not be maintaining two different HTML pages that contain the same content! 
2. If you make the corrections in the source XML file, that is less brittle. The HTML is only a display view and those files should be considered less stable and more temporary, since they are produced by transforming the XML. 

### Documenting the Code
You provided an "About" page that shares code blocks by mousing over headings. That is one way to share a small portion of code, but you did so without explanation beyond the headings. You should provide some *discussion* of your work, rather than just the code blocks by themselves. 

We are missing a link to your GitHub repo (where we can see the code) from your website! We are more importantly missing a discussion of the team's coding decisions anywhere on the project website. I know from talking to your team this semester that you made some very significant decisions in your schema design for the project, for example, and about what kinds of information you wanted to be marking and sharing. You could comment more on information you marked in the XML that maybe we can't see so clearly at first in the HTML webpage. 

Pointing us directly to the XML files is always important in a project like this. Of course I know where to find them, but your XML markup really is foundation of this project and it's human readable and worth sharing, even if it's not as "pretty" as the website. Digital Humanities projects make a point of sharing all the code "under the hood" as a way of showing your work, and that's important for paying the project forward, too. Scholars and fans and even future students looking at this project would benefit from a view of your XML and your schema, so we really should be including it. The project is grounded in the XML first, and the HTML is built on top of it, so the XML deserves an appearance or a link  plus some explanation on that "About" page. 

### Closing Comments
This is a mixed review. Some of you did very good, responsible work on this project, such as in the design of the website in the XSLT efforts, and in the transcription work that one of you was trying to correct. You researched backgrounds and contexts on the people and places involved, and that information is well displayed on the site. However there are missing portions in the transcription, and evidence of confusion over the file management for the project.

I am aware that this team experienced difficulties in communicating and collaborating this semester. Such difficulties are common in student team projects, and yes, we know from long experience how uncomfortable and awkward collaboration can be. Often teams learn how to work together during the inevitable "coding sprint" in the closing weeks of a semester, but sometimes things don't work out as well as we would hope. What I want each of you to learn from this experience is the importance of:
* written documentation to ensure your team knows what it's doing from week to week and milestone to milestone
* making sure everyone knows how to find each other and not tolerating anyone—including yourself—"falling out of the loop."

For each of you, this is your first experience with team collaboration on an archival project, and that did put you at a comparative disadvantage to most of the other project teams, which had one or two more senior / experienced  students. I am confident that your next team experience will be more professional if you are able to learn from what caused difficulties this time. Each of you is capable of being a strong team member, and like anything, this takes practice and experience to improve. We can't resolve every difficulty if a team member is not communicating, but we can resolve *some* of them, especially when clear documentation can improve your signals to each other. 


