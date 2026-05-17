<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurant.model.Table" %>
<%@ page import="com.restaurant.dao.TableDAO" %>
<jsp:include page="includes/header.jsp" />

<head>
    <title>Bloom - Our Tables</title>
    <style>
        body {
            background: url('images/tablepage_bg.png') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
        }
        .tables-hero {
            padding: 80px 0 40px;
            text-align: center;
        }
        .tables-hero h2 {
            font-family: 'Playfair Display', serif;
            color: #7a111e;
            font-size: 3rem;
            margin-bottom: 15px;
            font-weight: 700;
        }
        .table-card {
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(25px) saturate(200%);
            -webkit-backdrop-filter: blur(25px) saturate(200%);
            border: 1px solid rgba(255, 255, 255, 0.5); 
            border-top: 1px solid rgba(255, 255, 255, 0.8);
            border-left: 1px solid rgba(255, 255, 255, 0.8); 
            border-radius: 32px;
            overflow: hidden;
            box-shadow: 
                0 20px 50px rgba(0,0,0,0.1), 
                inset 0 0 80px rgba(255, 255, 255, 0.1),
                inset 0 0 1px 1px rgba(255, 255, 255, 0.5);
            transition: all 0.6s cubic-bezier(0.16, 1, 0.3, 1);
            margin-bottom: 30px;
            height: 100%;
            display: flex;
            flex-direction: column;
            position: relative;
        }
    </style>
</head>
<body>
</body>
</html>
