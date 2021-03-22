<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE TEI [
<!ENTITY tiret "<choice><orig><pc></pc></orig><reg><pc>-</pc></reg></choice>">
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Configuration de la sortie en HTML -->
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <!-- Exclusion des espaces non voulus -->
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="TEI">
        
        <!-- variable pour récupérer le nom et le chemin du fichier courant -->
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
        </xsl:variable>
        
        <!-- variable des chemins vers les templates HTML -->
        <xsl:variable name="pathAccueil">
            <xsl:value-of select="concat($witfile,'accueil','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathPresentation">
            <xsl:value-of select="concat($witfile, 'presentation','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathOriginal">
            <xsl:value-of select="concat($witfile,'original','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathNormalisee">
            <xsl:value-of select="concat($witfile,'narmalisee','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathComparaison">
            <xsl:value-of select="concat($witfile, 'comparaison','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathIndex">
            <xsl:value-of select="concat($witfile, 'index','.html')"/>
        </xsl:variable>
        
        <!-- Autres variables -->
        <xsl:variable name="titre">
            <xsl:value-of select="//titleStmt/title"/>
        </xsl:variable>
        
        
        <xsl:result-document href="{$pathAccueil}">
            <html>
                <head>
                    <xsl:call-template name="metaHeader"/>
                    <title>
                        <xsl:value-of select="concat($titre,' | Accueil')"/>
                    </title>
                </head>
      
      
            <body>
                <xsl:call-template name="barreNavigation"/>
                <h1><xsl:value-of select="//titleStmt/title"/></h1>
                <div>
                    <h2>Le projet</h2>
                    <ul>
                        <li>
                            <xsl:value-of select="//titleStmt//resp"/>
                        </li>
                        <li>
                            Par <xsl:value-of select="//titleStmt/respStmt/name"/>
                        </li>
                        <li>
                            Proposer une édition numérique de quelques folios de <a href="{//publicationStmt/distributor/@facs}">Bestiaire d'Amour</a>
                        </li>
                    </ul>
                    <div class="row">
                        <div class="col"><img class="fit-picture"
                        src="./230v.jpeg"
                        alt="Folio 230v"/></div>
                        <div class="col">
                            <img class="fit-picture"
                        src="./231r.jpeg"
                        alt="Folio 231r"/></div>
                            <div class="col"><img class="fit-picture"
                        src="./231v.jpeg"
                        alt="Folio 231v"/></div></div>
                </div>
            </body>
            </html>
        </xsl:result-document>
        
        
        
        <xsl:result-document href="{$pathPresentation}">
        <html>
            <head>
                <xsl:call-template name="metaHeader"/>
                <title>
                    <xsl:value-of select="concat($titre,' | Le manuscrit')"/>
                </title>
            </head>
        <body>
            <xsl:call-template name="barreNavigation"/>
            <h1><xsl:value-of select="//titleStmt/title"/></h1>
            
            <xsl:call-template name="presentationMS"/>
            <span>
                <a href="{$pathAccueil}">Retour accueil</a>
            </span>
        </body>
        </html>
        </xsl:result-document>
            
            
            
        <xsl:result-document href="{$pathOriginal}">
            <html>
                <head>
                    <xsl:call-template name="metaHeader"/>
                    <title>
                        <xsl:value-of select="concat($titre,' | Édition imitative')"/>
                    </title>
                </head>
            <body>
                <xsl:call-template name="barreNavigation"/>
                <h1><xsl:value-of select="//titleStmt/title"/></h1>
                <span>
                    <a href="{//publicationStmt/distributor/@facs}">Lien vers le manuscrit</a>
                </span>
            <div>
                <h2>Transcription imitative</h2>
                <div>
                    <ul>
                    Découvrez une transcription imitative de nos folios. La ponctuation originale a été rapporté et les abbréviations ne sont pas développées. 
                    </ul>
                    
                </div>
                <div>
                    <ul>
                        <xsl:apply-templates select="//text//div2" mode="orig"/>
                    </ul>
                </div>
            </div>
            </body>
            </html>
        </xsl:result-document>
        
        <xsl:result-document href="{$pathNormalisee}">
            <html>
                <head>
                    <xsl:call-template name="metaHeader"/>
                    <title>
                        <xsl:value-of select="concat($titre,' | Édition normalisée')"/>
                    </title>
                </head>
                
            <body>
                <xsl:call-template name="barreNavigation"/>
                <h1><xsl:value-of select="//titleStmt/title"/></h1>
                <span>
                    <a href="{//publicationStmt/distributor/@facs}">Lien vers le manuscrit</a>
                </span>
                <div>
                <h2>Transcription normalisée</h2>
                    <h3>
                        Découvrez notre proposition de transcription normalisée. 
                        Les abbréviations ont été développé, la distinction des lettres ramistes a été faite, la ponctuation a été normalisée. 
                        Bonne lecture !
                    </h3>
                    
                    <div>
                    <ul><xsl:apply-templates select="//text//div2" mode="reg"/></ul>
   
                 </div>
                 </div>
                <span>
                    <a href="{$pathAccueil}">Retour accueil</a>
                </span>
            </body>
            </html>
        </xsl:result-document>
                
                
                
        <xsl:result-document href="{$pathComparaison}">
                    <html>
                        <head>
                            <xsl:call-template name="metaHeader"/>
                            <title>
                                <xsl:value-of select="concat($titre,' | Édition comparative')"/>
                            </title>
                        </head>
                    
                    
                    <body>
                        <xsl:call-template name="barreNavigation"/>
                        <h1><xsl:value-of select="//titleStmt/title"/></h1>
                        <span>
                            <a href="{//publicationStmt/distributor/@facs}">Lien vers le manuscrit</a>
                        </span>
                        
                
            <div>
                <h2>Comparaison des deux versions</h2>
                <div class="row">
                    
                    <div class="col">
                        <h4>Version imitative</h4>
                        <ul>
                            <xsl:apply-templates select="//text//div2" mode="orig"/>
                        </ul>
                    </div>
                    <div class="col">
                    <h4>Version modernisée</h4>
                    <ul>
                        <xsl:apply-templates select="//text//div2" mode="reg"/>
                    </ul>
                    </div>
                </div>
            </div>

        </body>
                        <span>
                            <a href="{$pathAccueil}">Retour accueil</a>
                        </span>
                    </html>
        </xsl:result-document>
        
        
        
        <xsl:result-document href="{$pathIndex}">
            <html>
                <head>
                    <xsl:call-template name="metaHeader"/>
                    <title>
                        <xsl:value-of select="concat($titre,' | Notices')"/>
                    </title>
                </head>
            
            
            <body>
                <xsl:call-template name="barreNavigation"/>
                <h1><xsl:value-of select="//titleStmt/title"/></h1>
                <span>
                    <a href="{//publicationStmt/distributor/@facs}">Lien vers le manuscrit</a>
                </span>
                
                
                <div>
                    <h2>Index</h2>
                    <div>Les miniatures :
                        <xsl:call-template name="miniature"/>
                    </div>  
                </div>
                
            </body>
                <span>
                    <a href="{$pathAccueil}">Retour accueil</a>
                </span>
            </html>
        </xsl:result-document>
        
    </xsl:template>





    <!-- Règle pour les métadonnées du header HTML -->
    <xsl:template name="metaHeader">
        <xsl:variable name="titre">
            <xsl:value-of select="//titleStmt/title"/>
        </xsl:variable>
        <xsl:variable name="auteur">
            <xsl:value-of select="//respStmt//name"/>
        </xsl:variable>
        <xsl:variable name="manuscrit">
            <xsl:value-of select="//sourceDesc//repository"/>
            <xsl:text>, MS </xsl:text>
            <xsl:value-of select="//sourceDesc//msIdentifier/idno"/>
        </xsl:variable>
  
        <link rel="stylesheet" href="static/css/bootstrap.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta charset="UTF-8"/>
        <meta name="author" content="{$auteur}"/>
        <meta name="description" content="{$titre} ({$manuscrit})"/>
        <meta name="keywords" content="XSLT,XML,TEI"/>
    </xsl:template>


<!-- Barre de navigation -->
    
    <!-- variable pour récupérer le nom et le chemin du fichier courant -->
    <xsl:variable name="witfile">
        <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
    </xsl:variable>
    
    <!-- variable des chemins vers les templates HTML -->
    <xsl:variable name="pathAccueil">
        <xsl:value-of select="concat($witfile,'accueil','.html')"/>
    </xsl:variable>
    <xsl:variable name="pathPresentation">
        <xsl:value-of select="concat($witfile, 'presentation','.html')"/>
    </xsl:variable>
    <xsl:variable name="pathOriginal">
        <xsl:value-of select="concat($witfile,'original','.html')"/>
    </xsl:variable>
    <xsl:variable name="pathNormalisee">
        <xsl:value-of select="concat($witfile,'narmalisee','.html')"/>
    </xsl:variable>
    <xsl:variable name="pathComparaison">
        <xsl:value-of select="concat($witfile, 'comparaison','.html')"/>
    </xsl:variable>
    <xsl:variable name="pathIndex">
        <xsl:value-of select="concat($witfile, 'index','.html')"/>
    </xsl:variable>
    <xsl:template name="barreNavigation">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="{$pathAccueil}">Bestiaire d'Amour</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="{$pathPresentation}">Le manuscrit</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$pathOriginal}">L'édition imitative</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$pathNormalisee}">L'édition normalisée</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$pathComparaison}">Comparaison d'édition</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$pathIndex}">Les notices</a>
                    </li>-
                </ul>
            </div>
        </nav>
    </xsl:template>
    
    <!-- Règle pour une version imitative -->
    <xsl:template match="choice" mode="orig">
        <xsl:value-of select="
            .//orig/text() |
            .//orig/pc/text() |
            .//abbr/text()"
        />

    </xsl:template>
    
    
    <!-- Règle pour une version normalisée de l'édition -->
    <xsl:template match="choice" mode="reg">
        <xsl:value-of select="
            .//reg/text() |
            .//reg/pc/text() |
            .//expan//text() "/>
    </xsl:template>
    


    <!-- Règles pour aller à la ligne : -->
    
    <xsl:template match="div2" mode="ligne">
        
       <xsl:for-each select="//body//lb">
           <xsl:value-of select="."/>
       </xsl:for-each>
   
    </xsl:template>
   
    <!-- Règle pour afficher les miniatures -->
    <xsl:template match="figure" name="miniature">
        <xsl:for-each select="//figure/@sameAs">
        <div>
            <a href="{//figure/@sameAs}">Miniature</a>
        </div>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Règle pour afficher les facsimilés -->
    <xsl:template match="figure" name="facsimile">
        <xsl:for-each select="//pb/@facs">
            <div>
                <a href="{//pb/@facs}">Facsimilé</a>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- Règle pour afficher la présentation du manuscrit -->
    <xsl:template name="presentationMS">
        
    <div class="container">
        <h2>Présentation du manuscrit </h2>
        
        <ul>
        <a class="btn btn-outline-dark" href="{//distributor/@facs}">Consulter le manuscrit</a>
        </ul>
        
        <ul>
            <h6>Identification :</h6>
            <xsl:apply-templates select="//sourceDesc//msIdentifier"/>
        </ul>
        <ul>
            <h6>Le manuscrit :</h6>
            <xsl:apply-templates select="//sourceDesc//head"/>
        </ul>
        
        <ul>
            <h6>Oeuvres contenues dans le manuscrit</h6>
            <xsl:for-each select="//sourceDesc//msContents//msItemStruct">
                <li><xsl:value-of select="locus/text()"/> : 
                    <xsl:value-of select="title/text()"/>,
                    <em><xsl:value-of select="incipit/text()"/></em>.
                </li>
        </xsl:for-each>
        </ul>
        <ul>
            <h6>Sa description :</h6>
            <xsl:apply-templates select="//sourceDesc//physDesc"/>
        </ul>
        <ul>
            <h6>Son histoire :</h6>
            <li>Origine : <xsl:value-of select="//origin"/>
            </li>
            <li>
                <xsl:apply-templates select="//provenance/p"/>
            </li>
            <li>
                <em>Source : <xsl:apply-templates select="//provenance/listBibl"/></em>
            </li>
        </ul>
    <ul>
        <h6>Accès au manuscrit et réutilisation :</h6>
        La <xsl:value-of select="//publicationStmt/distributor"/> a numérisé ce manuscrit le <xsl:value-of select="//publicationStmt/date"/>. <br/>
        Conditions de réutisation : <xsl:value-of select="//publicationStmt/availability/p/text()"/> 
    </ul>
        </div>
    </xsl:template>
    
    
    <!-- règle pour l'index 
    <xsl:template name="index">
        <xsl:for-each select="//div3">
            <div> 
                <h4>
                    
                    Notice n° <xsl:value-of select="//div3/@n"/> : " <xsl:value-of select="//div3/@xml:id"/> "
                    Ligne  <xsl:value-of select="//div3//lb/@n"/> à  <xsl:value-of select="//div3//lb/@n"/>.
                </h4>
             
                <p>
                    <xsl:value-of select="."/>
                    
                    <xsl:variable name="idNotice">
                        <xsl:value-of select="div3/@xml:id"/>
                    </xsl:variable>
                
                    <xsl:text> : </xsl:text>
                    
                    
                    <xsl:for-each select="ancestor::TEI//body//div3[@xml:id=$idNotice]">
                        <xsl:value-of select="text()"/>
                    </xsl:for-each>
                </p>
            </div>
        </xsl:for-each>
    </xsl:template>
    -->

</xsl:stylesheet>