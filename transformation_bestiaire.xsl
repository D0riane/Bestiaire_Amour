<?xml version="1.0" encoding="UTF-8"?>

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
        
        <!-- Variable pour récupérer le nom et le chemin du fichier courant -->
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
        </xsl:variable>
        
        <!-- Variable des chemins vers les templates HTML -->
        <xsl:variable name="pathAccueil">
            <xsl:value-of select="concat($witfile,'accueil','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathPresentation">
            <xsl:value-of select="concat($witfile, 'presentation','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathFacsimile">
            <xsl:value-of select="concat($witfile, 'facsimile','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathOriginal">
            <xsl:value-of select="concat($witfile,'originale','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathNormalisee">
            <xsl:value-of select="concat($witfile,'narmalisee','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathComparaison">
            <xsl:value-of select="concat($witfile, 'comparaison','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathMiniature">
            <xsl:value-of select="concat($witfile, 'miniature','.html')"/>
        </xsl:variable>
        
        <!-- Autres variables -->
        <xsl:variable name="titre">
            <xsl:value-of select="//titleStmt/title"/>
        </xsl:variable>
        <xsl:variable name="auteur">
            <xsl:value-of select="//respStmt//name/forename"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="//respStmt//name/surname"/>
        </xsl:variable>
        <xsl:variable name="numMS">
            <xsl:value-of select="//distributor/@facs"/>
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
                    <div class="jumbotron jumbotron-fluid">
                        <div class="container">
                            <h1 class="display-4">
                                <xsl:value-of select="$titre"/>
                            </h1>
                            <p class="lead">
                                Proposition d'une édition numérique des folios 
                                <xsl:for-each select="//div2//pb/@n">
                                    <xsl:if test="position()!= last()"><xsl:value-of select="."/>, </xsl:if>
                                    <xsl:if test="position()= last()">et <xsl:value-of select="."/></xsl:if>
                                </xsl:for-each>
                                du manuscrit <a href="{//publicationStmt/distributor/@facs}"><xsl:value-of select="//sourceDesc//msIdentifier/idno"/></a> 
                                de la <xsl:value-of select="//publicationStmt/distributor"/>, <em><xsl:value-of select="//sourceDesc//head/title"/></em> comprenant 
                                le <em>Bestiaire d'Amour</em>. Elle repose sur un <xsl:value-of select="lower-case(//titleStmt//resp)"/>
                            </p>
                        </div>
                    </div>
                    <div>
                        <table class="row">
                            <td width="33%" align='center'>
                                <img class="fit-picture" width="80%" src="./230v.jpeg" alt="Folio 230v"/>
                            </td>
                            <td width="33%" align='center'>
                                <img class="fit-picture" width="80%" src="./231r.jpeg" alt="Folio 231r"/>
                            </td>
                            <td width="33%" align='center' >
                                <img class="fit-picture" width="80%" src="./231v.jpeg" alt="Folio 231v"/>
                            </td>
                        </table>
                    </div>
                    <xsl:call-template name="footer"/>
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
                <div class="jumbotron jumbotron-fluid">
                    <div class="container">
                        <h2 class="display-6">Présentation du manuscrit
                            <a class="btn btn-outline-dark" href="{$numMS}">Consulter le manuscrit</a></h2>
                        <xsl:call-template name="presentationMS"/>
                        <span><a class="btn btn-outline-dark" href="{$pathAccueil}">Retour à l'accueil</a></span>
                    </div>
                </div>
                <xsl:call-template name="footer"/>
            </body>
            </html>
        </xsl:result-document>
        
        
        <xsl:result-document href="{$pathFacsimile}">
            <html>
                <head>
                    <xsl:call-template name="metaHeader"/>
                    <title>
                        <xsl:value-of select="concat($titre,' | Les fac-similés')"/>
                    </title>
                </head>
                <body>
                    <xsl:call-template name="barreNavigation"/>
                    <div class="jumbotron jumbotron-fluid">
                        <div class="container">
                            <h2 class="display-6">Les fac-similés
                                <a class="btn btn-outline-dark" href="{$numMS}">Consulter le manuscrit</a>
                            </h2>
                            <div>
                                <table class="row">
                                    <tr>
                                        <td width="50%">
                                            <img class="fit-picture" width="100%" src="./230v.jpeg" alt="Folio 230v"/>
                                        </td>
                                        <td width="50%">
                                            <img class="fit-picture" width="100%"  src="./231r.jpeg" alt="Folio 231r"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="50%">
                                            <img class="fit-picture" width="100%"  src="./231v.jpeg" alt="Folio 231v"/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <span>
                                <a class="btn btn-outline-dark" href="{$pathAccueil}">Retour accueil</a>
                            </span>
                        </div>
                    </div>
                    <xsl:call-template name="footer"/>
                </body>
            </html>
        </xsl:result-document>
            
            
        <xsl:result-document href="{$pathOriginale}">
            <html>
                <head>
                    <xsl:call-template name="metaHeader"/>
                    <title>
                        <xsl:value-of select="concat($titre,' | Édition imitative')"/>
                    </title>
                </head>
                <body>
                   <xsl:call-template name="barreNavigation"/>
                    <div class="jumbotron jumbotron-fluid">
                        <div class="container">
                            <h2 class="display-6">La transcription facsimilaire
                                <a class="btn btn-outline-dark" href="{$numMS}">Consulter le manuscrit</a>
                            </h2>
                            <p class="lead">Découvrez une transcription facsimilaire de nos folios. 
                                La ponctuation originale a été rapportée et les abbréviations ne sont pas développées. 
                                Le folio sur la gauche vous permet de consulter en même temps le fac-similés 
                                correspondant à la transcription proposée. Bonne lecture !
                            </p>
                            
                            <xsl:for-each select="//facsimile/surface">
                                <xsl:variable name="url" select="graphic/@url"/>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-8">
                                            <img width="100%" src="{$url}" valign="middle"/>
                                        </div>
                                        <div class="col" style="overflow:scroll; height:170%">
                                            <xsl:for-each select="zone">
                                                <xsl:variable name="id" select="@xml:id"/>
                                                <xsl:variable name="facs" select="concat('#', $id)"/>
                                                <div>
                                                    <xsl:apply-templates select="//seg[@facs = $facs]" mode="orig"/>
                                                </div>
                                            </xsl:for-each>
                                        </div>
                                    </div>
                                </div>
                            </xsl:for-each>
                            <span>
                                <a class="btn btn-outline-dark" href="{$pathAccueil}">Retour accueil</a>
                            </span>
                        </div>
                    </div>
                    <xsl:call-template name="footer"/>
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
                    <div class="jumbotron jumbotron-fluid">
                        <div class="container">
                            <h2 class="display-6">La transcription normalisée
                                <a class="btn btn-outline-dark" href="{$numMS}">Consulter le manuscrit</a>
                            </h2>
                            <p class="lead">
                                Découvrez notre proposition de transcription normalisée. 
                                Les abbréviations ont été développées, la distinction des lettres ramistes a été faite, la ponctuation a été modernisée. 
                                Le folio sur la gauche vous permet de consulter en même temps le fac-similés correspondant à la transcription proposée. Bonne lecture !
                            </p>
                            
                            <xsl:for-each select="//facsimile/surface">
                                <xsl:variable name="url" select="graphic/@url"/>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-8">
                                            <img width="100%" src="{$url}" valign="middle"/>
                                        </div>
                                        <div class="col" style="overflow:scroll; height:170%">
                                            <xsl:for-each select="zone">
                                                <xsl:variable name="id" select="@xml:id"/>
                                                <xsl:variable name="facs" select="concat('#', $id)"/>
                                                <div>
                                                    <xsl:apply-templates select="//seg[@facs = $facs]" mode="reg"/>
                                                </div>
                                            </xsl:for-each>
                                        </div>
                                    </div>
                                </div>
                            </xsl:for-each>
                            
                            <span>
                                <a class="btn btn-outline-dark" href="{$pathAccueil}">Retour accueil</a>
                            </span>
                        
                        </div>
                    </div>
                    <xsl:call-template name="footer"/>
                </body>
            </html>
        </xsl:result-document>
                
                
        <xsl:result-document href="{$pathComparaison}">
            <html>
                <head>
                    <xsl:call-template name="metaHeader"/>
                    <title>
                        <xsl:value-of select="concat($titre,' | Comparaison des transcriptions')"/>
                    </title>
                </head>
                <body>
                    <xsl:call-template name="barreNavigation"/>
                        <div class="jumbotron jumbotron-fluid">
                            <div class="container">
                                <h2 class="display-6">La comparaison des transcriptions
                                    <a class="btn btn-outline-dark" href="{$numMS}">Consulter le manuscrit</a>
                                </h2>
                                <p class="lead">Nous vous proposons de comprarer les transcriptions proposées.</p>
                                <div class="row">
                                    <div class="col">
                                        <h4 class="lead">Version facsimilaire</h4>
                                        <ul><xsl:apply-templates select="//text//div2" mode="orig"/></ul>
                                    </div>
                                    <div class="col">
                                        <h4 class="lead">Version normalisée</h4>
                                        <ul><xsl:apply-templates select="//text//div2" mode="reg"/></ul>
                                    </div>
                                </div>
                                
                                <span>
                                    <a class="btn btn-outline-dark" href="{$pathAccueil}">Retour accueil</a>
                                </span>
                            </div>
                        </div>
                        <xsl:call-template name="footer"/>
                    </body>
            </html>
        </xsl:result-document>
        
        
        <xsl:result-document href="{$pathMiniature}">
            <html>
                <head>
                    <xsl:call-template name="metaHeader"/>
                    <title>
                        <xsl:value-of select="concat($titre,' | Notices')"/>
                    </title>
                </head>
                <body>
                    <xsl:call-template name="barreNavigation"/>
                    <div class="jumbotron jumbotron-fluid">
                        <div class="container">
                            <h2 class="display-6">Les miniatures et les notices
                                <a class="btn btn-outline-dark" href="{$numMS}">Consulter le manuscrit</a>
                            </h2>
                            <div>
                                <p class="leaf">Découvrez les miniatures associées à leur notice et à a leur texte.</p>
                                <xsl:call-template name="galerie"/>
                            </div>
                            
                            <span>
                                <a class="btn btn-outline-dark" href="{$pathAccueil}">Retour accueil</a>
                            </span>
                        
                        </div>
                    </div>
                    <xsl:call-template name="footer"/>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>




<!-- TEMPLATE HTML : Elements appelé sur chaque page. -->
    
    <!-- Les métadonnées du header HTML -->
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


    <!-- La barre de navigation -->
    
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
    <xsl:variable name="pathFacsimile">
        <xsl:value-of select="concat($witfile, 'facsimile','.html')"/>
    </xsl:variable>
    <xsl:variable name="pathOriginale">
        <xsl:value-of select="concat($witfile,'originale','.html')"/>
    </xsl:variable>
    <xsl:variable name="pathNormalisee">
        <xsl:value-of select="concat($witfile,'narmalisee','.html')"/>
    </xsl:variable>
    <xsl:variable name="pathComparaison">
        <xsl:value-of select="concat($witfile, 'comparaison','.html')"/>
    </xsl:variable>
    <xsl:variable name="pathMiniature">
        <xsl:value-of select="concat($witfile, 'miniature','.html')"/>
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
                        <a class="nav-link" href="{$pathFacsimile}">Les fac-similés</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$pathOriginale}">La transcription facsimilaire</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$pathNormalisee}">La transcription normalisée</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$pathComparaison}">Comparaison des transcriptions</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$pathMiniature}">Les miniatures</a>
                    </li>
                </ul>
            </div>
        </nav>
    </xsl:template>
    
    <!-- Footer -->
    <xsl:template name="footer">
        <xsl:variable name="auteur">
            <xsl:value-of select="//respStmt//name/forename"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="//respStmt//name/surname"/>
        </xsl:variable>
        <footer class="bg-light text-center text-lg-start">
            <div class="text-center p-3">Edition proposée par 
                <a href="https://github.com/D0riane"><xsl:value-of select="$auteur"/></a> - 
                <a href="https://www.chartes.psl.eu">M2 TNAH</a>
            </div>
        </footer>

    </xsl:template>



<!-- REGLE POUR L'AFFICHAGE DU CONTENU DES PAGES -->
    
    
    <!-- REGLE POUR LES TRANSCRIPTIONS -->

    <!-- Règle pour une version fac-similaire de la transcription -->
    <xsl:template match="choice" mode="orig">
        <xsl:value-of select="
            .//orig/text() |
            .//orig/pc/text() |
            .//abbr/text()"/>
    </xsl:template>
    
    <!-- Règle pour une version normalisée de la transcription -->
    <xsl:template match="choice" mode="reg">
        <xsl:value-of select="
            .//reg/text() |
            .//reg/pc/text() |
            .//expan//text() "/>
    </xsl:template>
   
    <!-- Règle pour mettre en gras les lettres enluminées en mode original    -->
    <xsl:template match="hi" mode="orig">
        <xsl:element name="strong">
            <xsl:choose>
                <xsl:when test="choice">
                    <xsl:apply-templates mode="orig"/>
                </xsl:when>
            <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
 
    <!-- Règle pour mettre en gras les lettres enluminées en mode normalisée    -->
    <xsl:template match="hi" mode="reg">
        <xsl:element name="strong">
            <xsl:choose>
                <xsl:when test="choice">
                    <xsl:apply-templates mode="reg"/>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
 
    <!-- Règle pour toujours présenter le texte avec des retours à la ligne comme dans le manuscrit.
    On y ajoute la numérotation proposée dans l'encodage du fichier si il n'y a pas de @n dans la balise seg, on . 
    On affiche une numérotation d'une ligne sur deux. 
    Nous utilisons pas la fonction count() à cause de la ligne 79. On veut être sûre que le numero de ligne 
    soit celui le même que celui du manuscrit et non celle de la présentation de l'édition. 
    Pour un affichage régulier des lignes, on prends en compte si le numéro comporte 1, 2 ou 3 chiffres
    -->
    <xsl:template match="seg" mode="#all">
        <xsl:choose>
            <xsl:when test="@n">
            <xsl:element name="li">
                <xsl:attribute name="n">
                    <xsl:value-of select="@n"/>
                </xsl:attribute>
                <xsl:attribute name="class">list-group-item</xsl:attribute>
                <xsl:choose>
                    <xsl:when test="ends-with(@n, '1')">
                        <small style="margin-right:10px">
                            [<xsl:value-of select="@n"/>]
                        </small>
                    </xsl:when>
                    <xsl:when test="ends-with(@n, '3')">
                        <small style="margin-right:10px">
                            [<xsl:value-of select="@n"/>]
                        </small>
                    </xsl:when>
                    <xsl:when test="ends-with(@n, '5')">
                        <small style="margin-right:10px">
                            [<xsl:value-of select="@n"/>]
                        </small>
                    </xsl:when>
                    <xsl:when test="ends-with(@n, '7')">
                        <small style="margin-right:10px">
                            [<xsl:value-of select="@n"/>]
                        </small>
                    </xsl:when>
                    <xsl:when test="ends-with(@n, '9')">
                        <small style="margin-right:10px">
                            [<xsl:value-of select="@n"/>]
                        </small>
                    </xsl:when>
                    <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="string-length(@n)=1"><span style="margin-right:30px"></span></xsl:when>
                                <xsl:when test="string-length(@n)=2"><span style="margin-right:40px"></span></xsl:when>
                                <xsl:when test="string-length(@n)=3"><span style="margin-right:50px"></span></xsl:when>
                            </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates mode="#current"/>
            </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <!-- Si il n'y a pas de @n, on utilise le n° de facs que l'on sait identique.. Un seul cas dans notre édition (l.79) -->
                <xsl:element name="li">
                    <xsl:attribute name="class">list-group-item</xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="ends-with(@facs, '1')">
                            <small style="margin-right:10px">
                                [<xsl:value-of select="replace(@facs, '#l', '')"/>]
                            </small>
                        </xsl:when>
                        <xsl:when test="ends-with(@facs, '3')">
                            <small style="margin-right:10px">
                                [<xsl:value-of select="replace(@facs, '#l', '')"/>]
                            </small>
                        </xsl:when>
                        <xsl:when test="ends-with(@facs, '5')">
                            <small style="margin-right:10px">
                                [<xsl:value-of select="replace(@facs, '#l', '')"/>]
                            </small>
                        </xsl:when>
                        <xsl:when test="ends-with(@facs, '7')">
                            <small style="margin-right:10px">
                                [<xsl:value-of select="replace(@facs, '#l', '')"/>]
                            </small>
                        </xsl:when>
                        <xsl:when test="ends-with(@facs, '9')">
                            <small style="margin-right:10px">
                                [<xsl:value-of select="replace(@facs, '#l', '')"/>]
                            </small>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="string-length(@facs)=3"><span style="margin-right:30px"></span></xsl:when>
                                <xsl:when test="string-length(@facs)=4"><span style="margin-right:40px"></span></xsl:when>
                                <xsl:when test="string-length(@facs)=5"><span style="margin-right:50px"></span></xsl:when>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                <xsl:apply-templates mode="#current"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    

    <!-- Règle pour respecter la mise en page des paragraphes et des notices -->
    
    <xsl:template match="//div3" mode="#all">
        <xsl:element name="div">
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//div3//p" mode="#all">
        <xsl:element name="p">
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
    
    
    
    <!-- REGLE POUR LA PRESENTATION CODICOLOGIQUE DU MANUSCRIT -->
    
    <xsl:template name="presentationMS">
        <xsl:variable name="baseJonas">
            <xsl:value-of select="//provenance//bibl//distributor/text()"/>
        </xsl:variable>
        
    <div class="container">
        <ul>
            <h6>Le manuscrit :</h6>
            <ul>
                <li>
                <em><xsl:value-of select="//sourceDesc//head/title"/></em>, daté de 
                    <xsl:value-of select="//sourceDesc//head/origDate"/>. 
                </li>
                <li>Informations complémentaires :
                    <xsl:value-of select="//sourceDesc//head/note"/>
                </li>
            </ul>
        </ul>
        
        <ul>
            <h6>Identification :</h6>
            <ul>
                <li>
                    Localisation :
                    <xsl:value-of select="//sourceDesc//msIdentifier/repository"/>, 
                    <xsl:value-of select="//sourceDesc//msIdentifier/settlement"/>,
                    <xsl:value-of select="//sourceDesc//msIdentifier/country"/>
                </li>
                <li>
                    Cote : 
                    <xsl:value-of select="//sourceDesc//msIdentifier/idno"/>
                </li>
                <li>
                    Anciennes cotes : 
                    <xsl:value-of select="//sourceDesc//msIdentifier/altIdentifier[1]"/>,
                    <xsl:value-of select="//sourceDesc//msIdentifier/altIdentifier[2]"/>
                </li>
            </ul>
        </ul>
        
        <ul>
            <h6>Oeuvres contenues dans le manuscrit</h6>
            <xsl:for-each select="//sourceDesc//msContents//msItemStruct">
                <ul>
                    <li><xsl:value-of select="locus/text()"/> : 
                    <xsl:value-of select="title/text()"/>,
                    <em><xsl:value-of select="incipit/text()"/></em>.
                </li>
                </ul>
            </xsl:for-each>
        </ul>
        
        <ul>
            <h6>Sa description codicologique:</h6>
            <ul>
                <li>
                    Codex :
                    <xsl:value-of select="//sourceDesc//material"/>,
                    <xsl:value-of select="//sourceDesc//measure[1]"/> (<xsl:value-of select="//sourceDesc//foliation"/>), 
                    <xsl:value-of select="//sourceDesc//measure[2]"/> x <xsl:value-of select="//sourceDesc//measure[3]"/>, 
                    <xsl:value-of select="//sourceDesc//@writtenLines"/> lignes par page réparties en
                    <xsl:value-of select="//sourceDesc//@columns"/> colonnes.
                </li>
                <li>
                    Décorations :
                    <ul>
                        <xsl:for-each select="//sourceDesc//decoNote">
                            <li><xsl:value-of select="p"/></li>
                    </xsl:for-each>
                    </ul>
                </li>
                <li>
                    Reliure : <xsl:value-of 
                        select="//sourceDesc//physDesc/bindingDesc//p"/>
                </li>
            </ul>
        </ul>
        
        <ul>
            <h6>Son histoire :</h6>
            <ul>
                <li>Origine : <xsl:value-of select="//origin"/></li>
                <li><xsl:value-of select="//provenance/p"/></li>
                <li>
                    Source : 
                    <xsl:value-of select="//provenance//bibl//author[1]"/>, <xsl:value-of select="//provenance//bibl//author[2]"/>, 
                    <em><xsl:value-of select="//provenance//bibl//title"/></em>, 
                    <xsl:value-of select="//provenance//bibl//publisher"/>, <xsl:value-of select="//provenance//bibl//date"/>.<br/>
                    Permalink : <a href="{$baseJonas}"><xsl:value-of select="//provenance//bibl//distributor"/></a>.
                </li>
            </ul>
        </ul>
        
        <ul>
            <h6>Accès au manuscrit et réutilisation :</h6>
            <ul>
                <li>La <xsl:value-of select="//publicationStmt/distributor"/> a numérisé ce manuscrit le <xsl:value-of select="//publicationStmt/date"/>. </li>
                <li>Conditions de réutilisation : <xsl:value-of select="//publicationStmt/availability/p/text()"/></li>
            </ul>
        </ul>
    </div>
    </xsl:template>
    
    
    <!-- REGLES DE LA PAGE D'AFFICHAGE DES MINIATURES -->
    <!-- Nous proposons un tableau qui permet sur une ligne de présenter une miniature avec le numéro de sa notice, 
        ce qu'elle représente grâce au @xml:id de la notice et le texte (dans sa version normalisée) qui lui est lié.
        Pour cela, nous utilisons nous utilisons le lien IIIF vers l'image renseigné dans l'attribut @sameAs. -->
    
    
    <xsl:template name="galerie">
        <div>
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col" width="5%">N° de notice</th>
                        <th scope="col" width="10%">Notice</th>
                        <th scope="col" width="45%">Miniature</th>
                        <th scope="col" width="40%">Texte associé</th>
                    </tr>
                </thead>
                
                <tbody>
                    <xsl:for-each select="//body//figure">
                    <tr>
                        <td width="5%">N-<xsl:value-of select="parent::p/parent::div3/@n"/></td>
                        <td width="10%">" <xsl:value-of select="replace(parent::p/parent::div3/@xml:id, '_', ' ')"/> "</td>
                        <td width="45%">
                            <xsl:element name="img">
                                <xsl:attribute name="width">100%</xsl:attribute>
                                <xsl:attribute name="src">
                                    <xsl:value-of select="@sameAs"/>
                                </xsl:attribute>
                                <xsl:attribute name="alt">
                                    <xsl:value-of select="replace(@facs, '#', '')"/>
                                </xsl:attribute>
                            </xsl:element>
                        </td>
                        <td width="40%">
                            <xsl:apply-templates select="parent::p" mode="reg"/>
                        </td>
                    </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </div>
    </xsl:template>
    
</xsl:stylesheet>