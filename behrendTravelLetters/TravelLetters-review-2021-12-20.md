##  Review of the Behrend Travel Letters Project

* Site publication: <https://janman813.github.io/Travel_Letters_1950s/>
* GitHub: <https://github.com/Janman813/Travel_Letters_1950s>
* Developers: Janet Pituch, Katharine Hendricks, Eric Sandbloom
* Date of Evaluation: 2021-12-20
* Evaluated by: @ebeshero

### General  
The Behrends' travel letters in France turned out to be fascinating and bristling with references to places and people and interesting items and food, and your team's strength in this project was your effort to capture as much as you could, following the Behrend's adventures with your own markup! 

One problem with the project, though, is the team needed to take more time simply working on the website and how you would introduce the letters and the interesting things you marked. What did you learn about the Behrends' travels--what did they like to do, and what kinds of things impressed them in France? That could be written up on the main page to introduce the work you did on their letters. In writing up these comments, my emphasis is really on what you or other students coming after you might build on this project. The core of your project is very strong: your trancription and markup of the letters. It's important work of interest to a wider audience than just our class and it should outlast a semester project.  

### XML, project schema, file-naming conventions
Of all the project teams, your code was perhaps the most chock full of interesting mixed content markup (lots of markup inside those paragraphs). 
Your team was often updating your schema as you would rethink how to capture something or adjust how everyone was going to tag a phenomenon, like a crossed-out passage or a misspelled word. I like how you worked out a system with your attributes to hold the normalized spellings, since that was something Janet would eventually output in the HTML. As a result of all the interesting complexities you kept on finding in the letters, your schema was always up for some new revision, which meant lots of revising. I appreciate your collective teamwork in thinking about how to represent your documents in text encoding. 

One thing that could use more attention, though, is how you are handling the metadata for each letter. Usually an XML edition file will contain a section that doesn't contain a transcription, but information about the editing: who edited this, when you worked on it, as well as a little metadata about where it was found (in your case in the source volume, how many pages in, etc.) 

As the project was nearing completion, your team faced some challenges with having to assemble the photo files you took with your separately encoded XML documents. Coming up with some file-naming rules early might have helped here, so you could rename the image files to correspond wtih specific letters, and also give those filenames in the source XML. You want your image data to be connected to the XML first of all so you make it easier to process related things all together as you assemble your website. 

### XSLT 
Your XSLT processed your collection of XML letters and output them (with `<xsl:sort/>` that I helped with) in chronological order. The problem that Janet and I noticed with that XSLT is that it was outputting the "dummy" source XML document from oXygen twice, and the intention was to remove the extra copy of the FRANCE.xml letters from the top of the file to deal the problem. We didn't have time to figure out why the code was processing FRANCE twice, but the clean-up step was a stop-gap measure.  Unfortunately, in wrapping up the project so late, that step to remove the extra letters from the top was missed, so a) the letters don't appear to be coming out in order and b) the extra letter is generating duplicate `@id` values in the output. It's an easy fix, but needs to be made to clean up the processing. 

Other than this collection-processing issue, the XSLT is written very intricately to process as much of your XML markup as you could think of! I like the very late addition of the processing for your `<crossOut>` and `<misspelling>` and `<eSpace>` code so you can supply `<span>` elements with mouseover tooltips in `@title` attributes to show what word was misspelled or how Mary Behrend left an extra space. The sheer frequency of oddly misspelled words you were finding is really remarkable to see in your code! Maybe Mary Behrend was just a hasty typist, not too interested in error correction! I am betting that she was literally composing on the typewriter while traveling, just as we write on computer keyboards.

### Website: Navigation, Images, HTML
Your team definitely concentrated its energy on the transcription, encoding, and processing of the letters, and the website you developed to hold and feature your project could really use some more attention. 

The main page has two entries on its navigation bar, Main, and About. On the main (index.html) page we see a picture of the bound volume from the Behrend Library archives where you found the letters you worked with, but that could use some discussion: What is that book you are showing us? (I mean, I know what's in that book, but you should write up something to tell us about it: what can we find in it, and how much did you work with with from inside that book?)

I know you were concentrating on completing a semester project assignment, and in that context it can be difficult to think that your project might have a wider audience outside of our class or people already "in the know" about this unusual collection you're working wtih. But your project is definitely important and worth sharing more widely with anyone interested in learning more about the travelling Behrends, so your website should give the project a more helpful introductory framework. 

On your list of places they traveled, you provide one link on "France." The visitor doesn't know what to expect, necessarily, because you haven't explained what they will find on this website, and it seems strange that there isn't an entry on the site's navigation bar to take us to the HTML page representing the Behrend's travel letters from France. 

What we do have is your "About" page to introduce each of you. That page has a new menu bar at the top with some entries that seem like you didn't probably plan for them to be part of the final project(?) since they look like they're from my old homework assignments. The website files and the navigation menu definitely need some more attention. 

### France Letters edition and CSS
The heart of your project wasn't linked on the navigation menu, but it definitely represents your hard work on this project and deserves a better introduction on the website:
<https://janman813.github.io/Travel_Letters_1950s/FRANCE.html> 

One problem we face is trying to read everything that is highlighted on this page. The light turquoise on some of the text (is it for place names?) is nearly impossible to read because it does not provide enough contrast against the taupe background. Choosing a different background color would help, and so would darkening up that color.

Beware of choosing light colors for highlighting against a light background! Try plugging in your FRANCE.html page into the [Toptal color blindness test](https://www.toptal.com/designers/colorfilter/) to see it in grayscale, so you can see the problem. Color might not always be the best tool: turning to border boxes as you were doing for misspelled words makes sense: you could try [different combinations and varieties of borders](https://www.w3schools.com/css/css_border.asp) (with dashes, dots, doubled etc), but that's something you want to take some time doing and testing properly to make sure the combinations work. 

With so much colorful highlighting (or bordering) happening all over this page, your site visitors could use some guidance! The green borders around misspelled words and other textual phenomena (like extra spaces) that you marked help sort of subtly invite the reader to mouse over them to view their tooltips (seeing correctly spelled words). But we aren't really given any instruction here, and the reader might not notice those tooltips. So, you should take a moment somewhere near the top of the page to explain how to read the highlights and give us a legend showing the colors and a little explanation of what each one means. You need to teach your site visitors how to read your complex color/border coding. 

### Documenting your work
We don't really find much documentation to describe your process and workflow and decisions on this project. We are missing a link to your GitHub repo (where we can see the code) from your website. Somewhere on this site, you could be telling us about how even approached representing the Behrend's travel letters with all their assembled "mess" of photos and handwriting and typewritten material in your XML code in the first place. What decisions did you make to filters some of the material? (For example, I know you put forward the typewritten/handwritten parts, but you want to tell us a little about that decision.)

Pointing us directly to the XML files is always important in a project like this. Of course I know where to find them, but your XML markup really is foundation of this project and it's human readable and worth sharing, even if it's not as "pretty" as the website. Digital Humanities projects make a point of sharing all the code "under the hood" as a way of showing your work, and that's important for paying the project forward, too. Scholars and fans and even future students looking at this project would benefit from a view of your XML and your schema, so we really should be including it. The project is grounded in the XML first, and the HTML is built on top of it, so the XML deserves an appearance or a link  plus some explanation, maybe on your "About" page. 

### Closing Comments
I hope that on future projects, you will try to put some of the "meta" work more in the foreground. This is basically the hard work of planning ahead, and it involves thinking about your file names for images, your documentation and file management, and your explanation of your work flow as *part* of the step-by-step project assembly from the beginning, so you're not scrambling to fill these things in at the last minute. We all get better at this with experience, and I am confident you will, too. And I hope you'll find this project worth continuing. I'm going to try assembling a group of students to put our DIGIT 110 team projects together from this past semester in a Behrend Local History site that I'm hoping to launch on a Penn State server, and in that context, I think there will be plenty of opportunities to revise your work and introduce it more effectively to that wider audience I keep talking about. It can be very satisfying to see your work take on a new life after the semester ends! 

